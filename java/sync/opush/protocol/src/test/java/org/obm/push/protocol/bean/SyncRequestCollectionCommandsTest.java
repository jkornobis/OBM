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

import com.google.common.collect.ImmutableList;

@RunWith(SlowFilterRunner.class)
public class SyncRequestCollectionCommandsTest {

	@Test
	public void testBuilderFetchIdsIsNotRequired() {
		SyncRequestCollectionCommands commands = SyncRequestCollectionCommands.builder()
			.fetchIds(null).build();
		
		assertThat(commands.getFetchIds()).isEmpty();
	}

	@Test
	public void testBuilderFetchIdsValid() {
		SyncRequestCollectionCommands commands = SyncRequestCollectionCommands.builder()
			.fetchIds(ImmutableList.of("1234", "5678")).build();
		
		assertThat(commands.getFetchIds()).containsOnly("1234", "5678");
	}

	@Test
	public void testBuilderCommandsIsNotRequired() {
		SyncRequestCollectionCommands commands = SyncRequestCollectionCommands.builder()
			.commands(null).build();
		
		assertThat(commands.getCommands()).isEmpty();
	}

	@Test
	public void testBuilderCommandsValid() {
		SyncRequestCollectionCommands commands = SyncRequestCollectionCommands.builder()
			.commands(ImmutableList.of(
					SyncRequestCollectionCommand.builder().name("Delete").serverId("3").build(),
					SyncRequestCollectionCommand.builder().name("Fetch").serverId("8").build())).build();
		
		assertThat(commands.getCommands()).containsOnly(
				SyncRequestCollectionCommand.builder().name("Delete").serverId("3").build(),
				SyncRequestCollectionCommand.builder().name("Fetch").serverId("8").build());
	}
	
}