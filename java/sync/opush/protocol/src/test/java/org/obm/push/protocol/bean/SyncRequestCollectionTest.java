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
package org.obm.push.protocol.bean;

import static org.fest.assertions.api.Assertions.assertThat;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.obm.filter.SlowFilterRunner;
import org.obm.push.bean.FilterType;
import org.obm.push.bean.SyncCollectionOptions;
import org.obm.push.bean.SyncKey;
import org.obm.push.exception.activesync.ASRequestIntegerFieldException;
import org.obm.push.exception.activesync.ASRequestStringFieldException;
import org.obm.push.protocol.bean.SyncRequestCollection.Builder;

import com.google.common.collect.ImmutableList;

@RunWith(SlowFilterRunner.class)
public class SyncRequestCollectionTest {

	@Test(expected=ASRequestIntegerFieldException.class)
	public void testBuilderIdIsRequired() {
		builderWithRequirement().id(null).build();
	}

	@Test
	public void testBuilderIdValid() {
		SyncRequestCollection syncRequestCollection = builderWithRequirement().id(135).build();
		
		assertThat(syncRequestCollection.getId()).isEqualTo(135);
	}
	
	@Test(expected=ASRequestStringFieldException.class)
	public void testBuilderSyncKeyIsRequired() {
		builderWithRequirement().syncKey(null).build();
	}

	@Test
	public void testBuilderSyncKeyValid() {
		SyncRequestCollection syncRequestCollection = builderWithRequirement().syncKey(new SyncKey("blabla")).build();
		
		assertThat(syncRequestCollection.getSyncKey()).isEqualTo(new SyncKey("blabla"));
	}
	
	@Test
	public void testBuilderDataClassIsNotRequired() {
		SyncRequestCollection syncRequestCollection = builderWithRequirement().dataClass(null).build();
		
		assertThat(syncRequestCollection.getDataClass()).isNull();
	}

	@Test
	public void testBuilderDataClassValid() {
		SyncRequestCollection syncRequestCollection = builderWithRequirement().dataClass("Email").build();
		
		assertThat(syncRequestCollection.getDataClass()).isEqualTo("Email");
	}
	
	@Test
	public void testBuilderWindowSizeIsNotRequired() {
		SyncRequestCollection syncRequestCollection = builderWithRequirement().windowSize(null).build();
		
		assertThat(syncRequestCollection.getWindowSize()).isNull();
	}

	@Test
	public void testBuilderWindowSizeValid() {
		SyncRequestCollection syncRequestCollection = builderWithRequirement().windowSize(5).build();
		
		assertThat(syncRequestCollection.getWindowSize()).isEqualTo(5);
	}
	
	@Test
	public void testHasWindowSizeWhenNull() {
		SyncRequestCollection syncRequestCollection = builderWithRequirement().windowSize(null).build();
		
		assertThat(syncRequestCollection.hasWindowSize()).isFalse();
	}

	@Test
	public void testHasWindowSizeWhenValid() {
		SyncRequestCollection syncRequestCollection = builderWithRequirement().windowSize(5).build();
		
		assertThat(syncRequestCollection.hasWindowSize()).isTrue();
	}
	
	@Test
	public void testBuilderOptionsIsNotRequired() {
		SyncRequestCollection syncRequestCollection = builderWithRequirement().options(null).build();
		
		assertThat(syncRequestCollection.getOptions()).isNull();
	}

	@Test
	public void testBuilderOptionsValid() {
		SyncCollectionOptions options = new SyncCollectionOptions();
		options.setFilterType(FilterType.ONE_DAY_BACK);
		options.setConflict(2);
		options.setMimeTruncation(3);
		options.setMimeSupport(4);
		
		SyncRequestCollection syncRequestCollection = builderWithRequirement().options(options).build();
		
		assertThat(syncRequestCollection.getOptions()).isEqualTo(options);
	}
	
	@Test
	public void testHasOptionsWhenNull() {
		SyncRequestCollection syncRequestCollection = builderWithRequirement().options(null).build();
		
		assertThat(syncRequestCollection.hasOptions()).isFalse();
	}

	@Test
	public void testHasOptionsWhenValid() {
		SyncRequestCollection syncRequestCollection = builderWithRequirement().options(new SyncCollectionOptions()).build();
		
		assertThat(syncRequestCollection.hasOptions()).isTrue();
	}
	
	@Test
	public void testBuilderCommandsIsNotRequired() {
		SyncRequestCollection syncRequestCollection = builderWithRequirement().commands(null).build();
		
		assertThat(syncRequestCollection.getCommands()).isNull();
	}

	@Test
	public void testBuilderCommandsValid() {
		SyncRequestCollectionCommands commands = SyncRequestCollectionCommands.builder()
			.fetchIds(ImmutableList.of("1234"))
			.commands(ImmutableList.of(
					SyncRequestCollectionCommand.builder().serverId("100").name("Delete").build()))
			.build();
		
		SyncRequestCollection syncRequestCollection = builderWithRequirement().commands(commands).build();
		
		assertThat(syncRequestCollection.getCommands()).isEqualTo(commands);
	}

	private Builder builderWithRequirement() {
		return SyncRequestCollection.builder()
			.id(140)
			.syncKey(new SyncKey("1234"));
	}
}