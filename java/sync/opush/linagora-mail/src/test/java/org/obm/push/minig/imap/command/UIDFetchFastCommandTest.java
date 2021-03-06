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
package org.obm.push.minig.imap.command;

import static org.fest.assertions.api.Assertions.assertThat;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.obm.filter.SlowFilterRunner;
import org.obm.push.mail.bean.MessageSet;
import org.obm.push.minig.imap.impl.IMAPResponse;

import com.google.common.collect.ImmutableList;

@RunWith(SlowFilterRunner.class)
public class UIDFetchFastCommandTest {
	
	@Test
	public void testHandleMultipleResponsesWithOnlyOneCorresponding() {
		IMAPResponse response = new IMAPResponse("OK", "* 16931 FETCH (FLAGS (Junk) UID 735417)");
		IMAPResponse response2 = new IMAPResponse("OK", "* 1 FETCH (FLAGS (\\Seen) UID 738 INTERNALDATE \"14-Dec-2012 10:56:18 +0100\" RFC822.SIZE 1321)");
		IMAPResponse response3 = new IMAPResponse("OK", "");

		UIDFetchFastCommand command = new UIDFetchFastCommand(MessageSet.singleton(738));
		command.handleResponses(ImmutableList.of(response, response2, response3));
		
		assertThat(command.getReceivedData()).hasSize(1);
	}
}
