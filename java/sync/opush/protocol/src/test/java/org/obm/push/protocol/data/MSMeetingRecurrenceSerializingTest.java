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
package org.obm.push.protocol.data;

import javax.xml.parsers.FactoryConfigurationError;

import org.fest.assertions.api.Assertions;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.obm.DateUtils;
import org.obm.filter.SlowFilterRunner;
import org.obm.push.bean.msmeetingrequest.MSMeetingRequest;
import org.obm.push.bean.msmeetingrequest.MSMeetingRequest.MsMeetingRequestBuilder;
import org.obm.push.bean.msmeetingrequest.MSMeetingRequestInstanceType;
import org.obm.push.bean.msmeetingrequest.MSMeetingRequestRecurrence;
import org.obm.push.bean.msmeetingrequest.MSMeetingRequestRecurrence.Builder;
import org.obm.push.bean.msmeetingrequest.MSMeetingRequestRecurrenceDayOfWeek;
import org.obm.push.bean.msmeetingrequest.MSMeetingRequestRecurrenceType;
import org.obm.push.utils.DOMUtils;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.google.common.collect.Lists;

@RunWith(SlowFilterRunner.class)
public class MSMeetingRecurrenceSerializingTest {

	@Test
	public void testMeetingRequestDayOfMonthNull() {
		MSMeetingRequestRecurrence meetingRequestRecurrence = initializedRequiredFieldsRecurrenceBuilder()
				.dayOfMonth(null)
				.build();
		
		Element encodedDocument = encode(meetingRequestRecurrence);
		
		Assertions.assertThat(tag(encodedDocument, ASEMAIL.DAY_OF_MONTH)).isNull();
	}

	@Test
	public void testMeetingRequestDayOfMonth() {
		MSMeetingRequestRecurrence meetingRequestRecurrence = initializedRequiredFieldsRecurrenceBuilder()
				.dayOfMonth(5)
				.build();
		
		Element encodedDocument = encode(meetingRequestRecurrence);

		Assertions.assertThat(tagValue(encodedDocument, ASEMAIL.DAY_OF_MONTH)).isEqualTo("5");
	}

	@Test
	public void testMeetingRequestMonthOfYearNull() {
		MSMeetingRequestRecurrence meetingRequestRecurrence = initializedRequiredFieldsRecurrenceBuilder()
				.monthOfYear(null)
				.build();
		
		Element encodedDocument = encode(meetingRequestRecurrence);
		
		Assertions.assertThat(tag(encodedDocument, ASEMAIL.MONTH_OF_YEAR)).isNull();
	}

	@Test
	public void testMeetingRequestMonthOfYear() {
		MSMeetingRequestRecurrence meetingRequestRecurrence = initializedRequiredFieldsRecurrenceBuilder()
				.monthOfYear(2)
				.build();
		
		Element encodedDocument = encode(meetingRequestRecurrence);
		
		Assertions.assertThat(tagValue(encodedDocument, ASEMAIL.MONTH_OF_YEAR)).isEqualTo("2");
	}

	@Test
	public void testMeetingRequestWeekOfMonthNull() {
		MSMeetingRequestRecurrence meetingRequestRecurrence = initializedRequiredFieldsRecurrenceBuilder()
				.weekOfMonth(null)
				.build();
		
		Element encodedDocument = encode(meetingRequestRecurrence);
		
		Assertions.assertThat(tag(encodedDocument, ASEMAIL.WEEK_OF_MONTH)).isNull();
	}

	@Test
	public void testMeetingRequestWeekOfMonth() {
		MSMeetingRequestRecurrence meetingRequestRecurrence = initializedRequiredFieldsRecurrenceBuilder()
				.weekOfMonth(3)
				.build();
		
		Element encodedDocument = encode(meetingRequestRecurrence);
		
		Assertions.assertThat(tagValue(encodedDocument, ASEMAIL.WEEK_OF_MONTH)).isEqualTo("3");
	}

	@Test
	public void testMeetingRequestDayOfWeekNull() {
		MSMeetingRequestRecurrence meetingRequestRecurrence = initializedRequiredFieldsRecurrenceBuilder()
				.dayOfWeek(null)
				.build();
		
		Element encodedDocument = encode(meetingRequestRecurrence);
		
		Assertions.assertThat(tag(encodedDocument, ASEMAIL.DAY_OF_WEEK)).isNull();
	}

	@Test
	public void testMeetingRequestDayOfWeekOneDay() {
		MSMeetingRequestRecurrence meetingRequestRecurrence = initializedRequiredFieldsRecurrenceBuilder()
				.dayOfWeek(Lists.newArrayList(MSMeetingRequestRecurrenceDayOfWeek.FRIDAY))
				.build();
		
		Element encodedDocument = encode(meetingRequestRecurrence);
		
		Assertions.assertThat(tagValue(encodedDocument, ASEMAIL.DAY_OF_WEEK))
				.isEqualTo(MSMeetingRequestRecurrenceDayOfWeek.FRIDAY.specificationValue());
	}

	@Test
	public void testMeetingRequestDayOfWeekComputed() {
		MSMeetingRequestRecurrence meetingRequestRecurrence = initializedRequiredFieldsRecurrenceBuilder()
				.dayOfWeek(Lists.newArrayList(
						MSMeetingRequestRecurrenceDayOfWeek.MONDAY,
						MSMeetingRequestRecurrenceDayOfWeek.WEDNESDAY,
						MSMeetingRequestRecurrenceDayOfWeek.SUNDAY))
				.build();
		
		Element encodedDocument = encode(meetingRequestRecurrence);
		
		int expectedComputedValue = 
						MSMeetingRequestRecurrenceDayOfWeek.MONDAY.asXmlValue() +
						MSMeetingRequestRecurrenceDayOfWeek.WEDNESDAY.asXmlValue() +
						MSMeetingRequestRecurrenceDayOfWeek.SUNDAY.asXmlValue();
		
		Assertions.assertThat(tagValue(encodedDocument, ASEMAIL.DAY_OF_WEEK))
				.isEqualTo(String.valueOf(expectedComputedValue));
	}

	@Test
	public void testMeetingRequestInterval() {
		MSMeetingRequestRecurrence meetingRequestRecurrence = initializedRequiredFieldsRecurrenceBuilder()
				.interval(5)
				.build();
		
		Element encodedDocument = encode(meetingRequestRecurrence);
		
		Assertions.assertThat(tagValue(encodedDocument, ASEMAIL.INTERVAL)).isEqualTo("5");
	}

	@Test
	public void testMeetingRequestOccurrencesNull() {
		MSMeetingRequestRecurrence meetingRequestRecurrence = initializedRequiredFieldsRecurrenceBuilder()
				.occurrences(null)
				.build();
		
		Element encodedDocument = encode(meetingRequestRecurrence);
		
		Assertions.assertThat(tag(encodedDocument, ASEMAIL.OCCURRENCES)).isNull();
	}

	@Test
	public void testMeetingRequestOccurrences() {
		MSMeetingRequestRecurrence meetingRequestRecurrence = initializedRequiredFieldsRecurrenceBuilder()
				.occurrences(100)
				.build();
		
		Element encodedDocument = encode(meetingRequestRecurrence);
		
		Assertions.assertThat(tagValue(encodedDocument, ASEMAIL.OCCURRENCES)).isEqualTo("100");
	}

	@Test
	public void testMeetingRequestTypeDaily() {
		MSMeetingRequestRecurrence meetingRequestRecurrence = initializedRequiredFieldsRecurrenceBuilder()
				.type(MSMeetingRequestRecurrenceType.DAILY)
				.build();
		
		Element encodedDocument = encode(meetingRequestRecurrence);
		
		Assertions.assertThat(tagValue(encodedDocument, ASEMAIL.TYPE))
				.isEqualTo(MSMeetingRequestRecurrenceType.DAILY.specificationValue());
	}

	@Test
	public void testMeetingRequestTypeMonthly() {
		MSMeetingRequestRecurrence meetingRequestRecurrence = initializedRequiredFieldsRecurrenceBuilder()
				.type(MSMeetingRequestRecurrenceType.MONTHLY)
				.build();
		
		Element encodedDocument = encode(meetingRequestRecurrence);
		
		Assertions.assertThat(tagValue(encodedDocument, ASEMAIL.TYPE))
				.isEqualTo(MSMeetingRequestRecurrenceType.MONTHLY.specificationValue());
	}

	@Test
	public void testMeetingRequestTypeMonthlyNthDay() {
		MSMeetingRequestRecurrence meetingRequestRecurrence = initializedRequiredFieldsRecurrenceBuilder()
				.type(MSMeetingRequestRecurrenceType.MONTHLY_NTH_DAY)
				.build();
		
		Element encodedDocument = encode(meetingRequestRecurrence);
		
		Assertions.assertThat(tagValue(encodedDocument, ASEMAIL.TYPE))
				.isEqualTo(MSMeetingRequestRecurrenceType.MONTHLY_NTH_DAY.specificationValue());
	}

	@Test
	public void testMeetingRequestTypeWeekly() {
		MSMeetingRequestRecurrence meetingRequestRecurrence = initializedRequiredFieldsRecurrenceBuilder()
				.type(MSMeetingRequestRecurrenceType.WEEKLY)
				.dayOfWeek(Lists.newArrayList(MSMeetingRequestRecurrenceDayOfWeek.SUNDAY))
				.build();
		
		Element encodedDocument = encode(meetingRequestRecurrence);
		
		Assertions.assertThat(tagValue(encodedDocument, ASEMAIL.TYPE))
				.isEqualTo(MSMeetingRequestRecurrenceType.WEEKLY.specificationValue());
	}

	@Test
	public void testMeetingRequestTypeYearly() {
		MSMeetingRequestRecurrence meetingRequestRecurrence = initializedRequiredFieldsRecurrenceBuilder()
				.type(MSMeetingRequestRecurrenceType.YEARLY)
				.monthOfYear(1)
				.build();
		
		Element encodedDocument = encode(meetingRequestRecurrence);
		
		Assertions.assertThat(tagValue(encodedDocument, ASEMAIL.TYPE))
				.isEqualTo(MSMeetingRequestRecurrenceType.YEARLY.specificationValue());
	}

	@Test
	public void testMeetingRequestTypeYearlyNthDay() {
		MSMeetingRequestRecurrence meetingRequestRecurrence = initializedRequiredFieldsRecurrenceBuilder()
				.type(MSMeetingRequestRecurrenceType.YEARLY_NTH_DAY)
				.dayOfWeek(Lists.newArrayList(MSMeetingRequestRecurrenceDayOfWeek.SUNDAY))
				.monthOfYear(1)
				.build();
		
		Element encodedDocument = encode(meetingRequestRecurrence);
		
		Assertions.assertThat(tagValue(encodedDocument, ASEMAIL.TYPE))
				.isEqualTo(MSMeetingRequestRecurrenceType.YEARLY_NTH_DAY.specificationValue());
	}

	@Test
	public void testMeetingRequestUntilNull() {
		MSMeetingRequestRecurrence meetingRequestRecurrence = initializedRequiredFieldsRecurrenceBuilder()
				.until(null)
				.build();
		
		Element encodedDocument = encode(meetingRequestRecurrence);
		
		Assertions.assertThat(tag(encodedDocument, ASEMAIL.UNTIL)).isNull();
	}

	@Test
	public void testMeetingRequestUntil() {
		MSMeetingRequestRecurrence meetingRequestRecurrence = initializedRequiredFieldsRecurrenceBuilder()
				.until(DateUtils.date("1970-01-01T12:00:00"))
				.build();
		
		Element encodedDocument = encode(meetingRequestRecurrence);
		
		Assertions.assertThat(tagValue(encodedDocument, ASEMAIL.UNTIL)).isEqualTo("1970-01-01T12:00:00.000'");
	}

	private Builder initializedRequiredFieldsRecurrenceBuilder() {
		return new MSMeetingRequestRecurrence.Builder()
				.type(MSMeetingRequestRecurrenceType.DAILY)
				.interval(1);
	}

	private MsMeetingRequestBuilder meetingRequestBuilderWithRequiredFields() {
		return new MSMeetingRequest.MsMeetingRequestBuilder()
				.dtStamp(DateUtils.date("1970-01-01T10:00:00"))
				.startTime(DateUtils.date("1970-01-01T12:00:00"))
				.endTime(DateUtils.date("1970-01-01T15:00:00"))
				.instanceType(MSMeetingRequestInstanceType.SINGLE)
				.globalObjId("a global object id")
				.recurrenceId(DateUtils.date("1970-01-01T15:00:00"));
	}

	private String tagValue(Element encodedDocument, ASEMAIL asemail) {
		return tag(encodedDocument, asemail).getTextContent();
	}

	private Node tag(Element encodedDocument, ASEMAIL asemail) {
		NodeList tags = tags(encodedDocument, asemail);
		if (tags.getLength() == 0) {
			return null;
		} else if (tags.getLength() == 1) {
			return tags.item(0);
		} else {
			throw new IllegalStateException("No more than one field expected for the tag : " + asemail.getName());
		}
	}

	private NodeList tags(Element encodedDocument, ASEMAIL asemail) {
		return encodedDocument.getElementsByTagName(asemail.asASValue());
	}

	private Element encode(MSMeetingRequestRecurrence meetingRequestRecurrence) throws FactoryConfigurationError {
		MSMeetingRequest meetingRequest = meetingRequestWithRecurrences(meetingRequestRecurrence);
		
		Element encodedDocument = createRootDocument();
		new MSMeetingRequestSerializer(new IntEncoder(), encodedDocument, meetingRequest).serializeMSMeetingRequest();
		return encodedDocument;
	}

	private MSMeetingRequest meetingRequestWithRecurrences(MSMeetingRequestRecurrence meetingRequestRecurrence) {
		MSMeetingRequest meetingRequest = meetingRequestBuilderWithRequiredFields()
				.recurrences(Lists.newArrayList(meetingRequestRecurrence))
				.build();
		return meetingRequest;
	}

	private Element createRootDocument() throws FactoryConfigurationError {
		return DOMUtils.createDoc("TestNameSpace", "RootElement").getDocumentElement();
	}
}