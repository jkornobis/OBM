/* ***** BEGIN LICENSE BLOCK *****
 * 
 * Copyright (C) 2011-2012  Linagora
 *
 * This program is free software: you can redistribute it and/or 
 * modify it under the terms of the GNU Affero General Public License as 
 * published by the Free Software Foundation, either version 3 of the 
 * License, or (at your option) any later version, provided you comply 
 * with the Additional Terms applicable for OBM connector by Linagora 
 * pursuant to Section 7 of the GNU Affero General Public License, 
 * subsections (b), (c), and (e), pursuant to which you must notably (i) retain 
 * the “Message sent thanks to OBM, Free Communication by Linagora” 
 * signature notice appended to any and all outbound messages 
 * (notably e-mail and meeting requests), (ii) retain all hypertext links between 
 * OBM and obm.org, as well as between Linagora and linagora.com, and (iii) refrain 
 * from infringing Linagora intellectual property rights over its trademarks 
 * and commercial brands. Other Additional Terms apply, 
 * see <http://www.linagora.com/licenses/> for more details. 
 *
 * This program is distributed in the hope that it will be useful, 
 * but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY 
 * or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License 
 * for more details. 
 *
 * You should have received a copy of the GNU Affero General Public License 
 * and its applicable Additional Terms for OBM along with this program. If not, 
 * see <http://www.gnu.org/licenses/> for the GNU Affero General Public License version 3 
 * and <http://www.linagora.com/licenses/> for the Additional Terms applicable to 
 * OBM connectors. 
 * 
 * ***** END LICENSE BLOCK ***** */
package org.obm.push.contacts;

import static org.easymock.EasyMock.createMock;
import static org.easymock.EasyMock.expect;
import static org.easymock.EasyMock.expectLastCall;
import static org.easymock.EasyMock.replay;
import static org.easymock.EasyMock.verify;
import static org.fest.assertions.api.Assertions.assertThat;

import java.util.Date;
import java.util.List;
import java.util.TreeSet;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.obm.configuration.ContactConfiguration;
import org.obm.filter.SlowFilterRunner;
import org.obm.push.backend.CollectionPath;
import org.obm.push.backend.CollectionPath.Builder;
import org.obm.push.bean.Credentials;
import org.obm.push.bean.Device;
import org.obm.push.bean.FolderSyncState;
import org.obm.push.bean.ItemChange;
import org.obm.push.bean.MSContact;
import org.obm.push.bean.PIMDataType;
import org.obm.push.bean.User;
import org.obm.push.bean.User.Factory;
import org.obm.push.bean.UserDataRequest;
import org.obm.push.exception.DaoException;
import org.obm.push.exception.activesync.CollectionNotFoundException;
import org.obm.push.service.impl.MappingService;
import org.obm.push.utils.DateUtils;
import org.obm.sync.auth.AccessToken;
import org.obm.sync.auth.AuthFault;
import org.obm.sync.auth.ServerFault;
import org.obm.sync.book.AddressBook;
import org.obm.sync.book.Contact;
import org.obm.sync.book.Folder;
import org.obm.sync.client.book.BookClient;
import org.obm.sync.client.login.LoginService;
import org.obm.sync.items.ContactChanges;

import com.google.common.collect.ImmutableList;
import com.google.common.collect.ImmutableSet;
import com.google.inject.Provider;

@RunWith(SlowFilterRunner.class)
public class ContactsBackendTest {

	private static final String COLLECTION_CONTACT_PREFIX = "obm:\\\\test@test\\contacts\\";
	
	private User user;
	private Device device;
	private UserDataRequest userDataRequest;
	
	private MappingService mappingService;
	private BookClient bookClient;
	private LoginService loginService;
	private ContactConfiguration contactConfiguration;
	private Provider<CollectionPath.Builder> collectionPathBuilderProvider;
	
	@Before
	public void setUp() {
		this.user = Factory.create().createUser("test@test", "test@domain", "displayName");
		this.device = new Device.Factory().create(null, "iPhone", "iOs 5", "my phone");
		this.userDataRequest = new UserDataRequest(new Credentials(user, "password"), "noCommand", device, null);
		
		this.mappingService = createMock(MappingService.class);
		this.bookClient = createMock(BookClient.class);
		this.loginService = createMock(LoginService.class);
		this.contactConfiguration = createMock(ContactConfiguration.class);
		this.collectionPathBuilderProvider = createMock(Provider.class);
	}
	
	@Test
	public void sortedByDefaultFolderName() {
		final String defaultFolderName = "contacts";
		
		Folder f1 = createFolder("users", -1);
		Folder f2 = createFolder("collected_contacts", 2);
		Folder f3 = createFolder(defaultFolderName, 3);
		Folder f4 = createFolder("my address book", 4);
		
		ImmutableList<Folder> immutableList = ImmutableList.of(f1, f2, f3, f4);
		TreeSet<Folder> treeset = new TreeSet<Folder>(
				new ComparatorUsingFolderName(defaultFolderName));
		treeset.addAll(immutableList);
		
		assertThat(treeset).hasSize(4);
		assertThat(treeset).contains(immutableList.toArray());
		assertThat(treeset.first().getName()).isEqualTo(defaultFolderName);
		assertThat(treeset.last().getName()).isEqualTo("users");
	}

	private Folder createFolder(String name, int uid) {
		Folder folder = new Folder();
		folder.setName(name);
		folder.setUid(uid);
		return folder;
	}
	
	@Test
	public void testGetPIMDataType() {
		ContactsBackend contactsBackend = new ContactsBackend(null, null, null, null, null);
		assertThat(contactsBackend.getPIMDataType()).isEqualTo(PIMDataType.CONTACTS);
	}

	@Test
	public void testGetItemEstimateSize() throws Exception {
		Date currentDate = DateUtils.getCurrentDate();
		FolderSyncState lastKnownState = new FolderSyncState("1234567890a");
		lastKnownState.setLastSync(currentDate);
		AccessToken token = new AccessToken(0, "OBM");

		expectLoginBehavior(token);

		expectListAllBooks(token);

		int contactUid = 2;
		Contact contact = newContactObject(contactUid);
		ContactChanges contactChanges = new ContactChanges(ImmutableList.<Contact> of(contact), ImmutableSet.<Integer> of(), currentDate);
		expect(bookClient.listContactsChanged(token, currentDate, 1))
			.andReturn(contactChanges).once();
		
		Builder collectionPathBuilder = expectBuildCollectionPath("folder");
		
		expectDefaultAddressAndParentForContactConfiguration();
		expectMappingServiceCollectionIdBehavior();
		
		expect(mappingService.getServerIdFor(contactUid, "2"))
			.andReturn("2");
		
		replay(loginService, bookClient, collectionPathBuilderProvider, contactConfiguration,
				mappingService, collectionPathBuilder);
		
		ContactsBackend contactsBackend = new ContactsBackend(mappingService, bookClient, loginService, contactConfiguration, collectionPathBuilderProvider);
		int itemEstimateSize = contactsBackend.getItemEstimateSize(userDataRequest, contactUid, lastKnownState, null);

		verify(loginService, bookClient, collectionPathBuilderProvider, contactConfiguration,
				mappingService, collectionPathBuilder);
		
		assertThat(itemEstimateSize).isEqualTo(1);
	}
	
	@Test
	public void testCreateOrUpdate() throws Exception {
		Integer collectionId = 2;
		String serverId = "2";
		String clientId = "1";
		AccessToken token = new AccessToken(0, "OBM");

		expectLoginBehavior(token);

		expectListAllBooks(token);
		
		Integer contactId = 2;
		Contact contact = newContactObject(contactId);
		expect(bookClient.modifyContact(token, 1, contact))
			.andReturn(contact).once();

		Builder collectionPathBuilder = expectBuildCollectionPath("folder");
		
		expectGetItemIdFromServerId(contactId, serverId);
		expectMappingServiceCollectionIdBehavior();
		
		expect(mappingService.getServerIdFor(contactId, serverId))
			.andReturn(serverId);

		expectDefaultAddressAndParentForContactConfiguration();
		
		replay(mappingService, loginService, bookClient, collectionPathBuilderProvider, contactConfiguration, collectionPathBuilder);
		
		MSContact msContact = new MSContact();
		
		ContactsBackend contactsBackend = new ContactsBackend(mappingService, bookClient, loginService, contactConfiguration, collectionPathBuilderProvider);
		String newServerId = contactsBackend.createOrUpdate(userDataRequest, collectionId, serverId, clientId, msContact);
		
		verify(mappingService, loginService, bookClient, collectionPathBuilderProvider, contactConfiguration, collectionPathBuilder);
		
		assertThat(newServerId).isEqualTo(serverId);
	}
	
	@Test
	public void testDelete() throws Exception {
		AccessToken token = new AccessToken(0, "OBM");
		int contactId = 2;
		String serverId = "2";

		expectLoginBehavior(token);

		expectListAllBooks(token);
		Contact contact = newContactObject(1);
		expect(bookClient.removeContact(token, 1, contactId))
			.andReturn(contact).once();
		
		expectGetItemIdFromServerId(contactId, serverId);
		expectMappingServiceCollectionIdBehavior();

		Builder collectionPathBuilder = expectBuildCollectionPath("folder");
		
		expectDefaultAddressAndParentForContactConfiguration();
		
		replay(loginService, bookClient, mappingService, contactConfiguration, collectionPathBuilderProvider, collectionPathBuilder);
		
		ContactsBackend contactsBackend = new ContactsBackend(mappingService, bookClient, loginService, contactConfiguration, collectionPathBuilderProvider);
		contactsBackend.delete(userDataRequest, contactId, serverId, true);
		
		verify(loginService, bookClient, mappingService, contactConfiguration, collectionPathBuilderProvider, collectionPathBuilder);
	}

	@Test
	public void testFetch() throws Exception {
		AccessToken token = new AccessToken(0, "OBM");
		int contactId = 2;
		String serverId = "2";

		expectLoginBehavior(token);

		expectListAllBooks(token);
		int contactUid = 1;
		Contact contact = newContactObject(contactUid);
		expect(bookClient.getContactFromId(token, contactUid, contactId))
			.andReturn(contact).once();

		
		expectGetItemIdFromServerId(contactId, serverId);
		expectMappingServiceCollectionIdBehavior();
		expect(mappingService.getCollectionIdFromServerId(serverId))
			.andReturn(contactId).once();
		expect(mappingService.getServerIdFor(contactId, "1"))
			.andReturn(serverId).once();
	
		expectDefaultAddressAndParentForContactConfiguration();

		Builder collectionPathBuilder = expectBuildCollectionPath("folder");
		
		replay(loginService, bookClient, mappingService, contactConfiguration, collectionPathBuilderProvider, collectionPathBuilder);
		
		ContactsBackend contactsBackend = new ContactsBackend(mappingService, bookClient, loginService, contactConfiguration, collectionPathBuilderProvider);
		List<ItemChange> itemChanges = contactsBackend.fetch(userDataRequest, ImmutableList.<String> of(serverId), null);
		
		verify(loginService, bookClient, mappingService, contactConfiguration, collectionPathBuilderProvider, collectionPathBuilder);
		
		ItemChange itemChange = new ItemChange(serverId, null, null, null, false);
		itemChange.setData(new ContactConverter().convert(contact));
		
		assertThat(itemChanges).hasSize(1);
		assertThat(itemChanges).contains(itemChange);
	}
	
	private void expectGetItemIdFromServerId(int contactId, String serverId) {
		expect(mappingService.getItemIdFromServerId(serverId))
			.andReturn(contactId).once();
	}
	
	private void expectListAllBooks(AccessToken token) throws ServerFault {
		expect(bookClient.listAllBooks(token))
			.andReturn(ImmutableList.<AddressBook> of(
					newAddressBookObject("folder", 1, false),
					newAddressBookObject("folder_1", 2, false)))
			.once();
	}

	private Contact newContactObject(int contactUid) {
		Contact contact = new Contact();
		contact.setUid(contactUid);
		return contact;
	}

	private AddressBook newAddressBookObject(String name, Integer uid, boolean readOnly) {
		return new AddressBook(name, uid, readOnly);
	}
	
	private void expectLoginBehavior(AccessToken token) throws AuthFault {
		expect(loginService.login(userDataRequest.getUser().getLoginAtDomain(), userDataRequest.getPassword()))
			.andReturn(token).anyTimes();
		
		loginService.logout(token);
		expectLastCall().anyTimes();
	}

	private void expectDefaultAddressAndParentForContactConfiguration() {
		expect(contactConfiguration.getDefaultAddressBookName())
			.andReturn("contacts").anyTimes();
		
		expect(contactConfiguration.getDefaultParentId())
			.andReturn("0").anyTimes();
	}

	private void expectMappingServiceCollectionIdBehavior() 
			throws CollectionNotFoundException, DaoException {
		
		expect(mappingService.getCollectionIdFor(userDataRequest.getDevice(), COLLECTION_CONTACT_PREFIX + "folder"))
			.andReturn(2).anyTimes();
		expect(mappingService.getCollectionIdFor(userDataRequest.getDevice(), COLLECTION_CONTACT_PREFIX + "folder_1"))
			.andReturn(3).anyTimes();
		
		expect(mappingService.collectionIdToString(1))
			.andReturn("1").anyTimes();
		expect(mappingService.collectionIdToString(2))
			.andReturn("2").anyTimes();
	}

	private Builder expectBuildCollectionPath(String displayName) {
		CollectionPath collectionPath = new ContactCollectionPath(displayName);
		CollectionPath.Builder collectionPathBuilder = expectCollectionPathBuilder(collectionPath, displayName);
		expectCollectionPathBuilderPovider(collectionPathBuilder);
		return collectionPathBuilder;
	}

	private CollectionPath.Builder expectCollectionPathBuilder(CollectionPath collectionPath, String displayName) {
		CollectionPath.Builder collectionPathBuilder = createMock(CollectionPath.Builder.class);
		expect(collectionPathBuilder.userDataRequest(userDataRequest))
			.andReturn(collectionPathBuilder).once();
		
		expect(collectionPathBuilder.pimType(PIMDataType.CONTACTS))
			.andReturn(collectionPathBuilder).once();
		
		expect(collectionPathBuilder.displayName(displayName))
			.andReturn(collectionPathBuilder).once();
		
		expect(collectionPathBuilder.build())
			.andReturn(collectionPath).once();
		
		return collectionPathBuilder;
	}

	private void expectCollectionPathBuilderPovider(CollectionPath.Builder collectionPathBuilder) {
			expect(collectionPathBuilderProvider.get())
				.andReturn(collectionPathBuilder).once();
	}
	
	private static class ContactCollectionPath extends CollectionPath {

		public ContactCollectionPath(String displayName) {
			super(COLLECTION_CONTACT_PREFIX + displayName, PIMDataType.CONTACTS, displayName);
		}
		
	}
}