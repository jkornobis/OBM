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
package org.obm.push.bean.ms;

import org.fest.assertions.api.Assertions;
import org.joda.time.DateTime;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.obm.filter.SlowFilterRunner;
import org.obm.push.bean.MSImportance;
import org.obm.push.bean.MSMessageClass;
import org.obm.push.bean.ms.MSEmail.MSEmailBuilder;
import org.obm.push.bean.msmeetingrequest.MSMeetingRequest;
import org.obm.push.bean.msmeetingrequest.MSMeetingRequestInstanceType;

@RunWith(SlowFilterRunner.class)
public class MSEmailTest {

	@Test
	public void testMSEmailBuilderDefaultImportanceValue() {
		MSEmailBuilder msEmailBuilder = new MSEmail.MSEmailBuilder();
		
		MSEmail msEmail = msEmailBuilder
				.build();
	
		Assertions.assertThat(msEmail.getImportance()).isEqualTo(MSImportance.NORMAL);
	}
	
	@Test
	public void testMSEmailBuilderDefaultMessageClassValue() {
		MSEmailBuilder msEmailBuilder = new MSEmail.MSEmailBuilder();
		
		MSEmail msEmail = msEmailBuilder
				.meetingRequest(anyMeetingRequest())
				.build();
	
		Assertions.assertThat(msEmail.getMessageClass()).isEqualTo(MSMessageClass.ScheduleMeetingRequest);
	}
	
	@Test
	public void testMSEmailBuilderMessageClassCanceled() {
		MSEmailBuilder msEmailBuilder = new MSEmail.MSEmailBuilder();
		
		MSEmail msEmail = msEmailBuilder
				.meetingRequest(anyMeetingRequest(), MSMessageClass.ScheduleMeetingCanceled)
				.build();
	
		Assertions.assertThat(msEmail.getMessageClass()).isEqualTo(MSMessageClass.ScheduleMeetingCanceled);
	}

	@Test(expected=IllegalArgumentException.class)
	public void testMSEmailBuilderPreconditionOnMessageClass() {
		MSEmailBuilder msEmailBuilder = new MSEmail.MSEmailBuilder();

		MSEmail msEmail = msEmailBuilder
				.meetingRequest(anyMeetingRequest(), null)
				.build();
	
		Assertions.assertThat(msEmail.getMessageClass()).isEqualTo(MSMessageClass.ScheduleMeetingRequest);
	}

	private MSMeetingRequest anyMeetingRequest() {
		return new MSMeetingRequest.MsMeetingRequestBuilder()
			.globalObjId("anyGlobalObjId")
			.instanceType(MSMeetingRequestInstanceType.SINGLE)
			.startTime(new DateTime("2012-07-10T07:00:00").toDate())
			.dtStamp(new DateTime("2012-04-24T07:57:07").toDate())
			.endTime(new DateTime("2012-07-10T07:15:00").toDate())
			.build();
	}
}