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
package org.obm.icalendar;

import java.io.IOException;
import java.io.InputStream;

import junit.framework.Assert;

import net.fortuna.ical4j.data.ParserException;

import org.fest.assertions.api.Assertions;
import org.junit.Test;

public class ICalendarTest {

	@Test
	public void testRightFormatICalendarBuilder() throws IOException, ParserException {
		ICalendar icalendar = icalendar("attendee.ics");
		Assertions.assertThat(icalendar.getICalendar()).isNotNull();
	}
	
	@Test(expected=IllegalStateException.class)
	public void testEmptyICalendarBuilder() throws IOException, ParserException {
		new ICalendar.Builder().build();
	}
	
	@Test(expected=IllegalStateException.class)
	public void testNullStreamICalendarBuilder() throws IOException, ParserException {
		new ICalendar.Builder().inputStream(null).build();
	}
	
	@Test(expected=IllegalStateException.class)
	public void testNullStringICalendarBuilder() throws IOException, ParserException {
		new ICalendar.Builder().iCalendar(null).build();
	}
	
	@Test(expected=IllegalArgumentException.class)
	public void testWrongFormatICalendarBuilder() throws IOException, ParserException {
		icalendar("wrong-format.ics");
	}
	
	private ICalendar icalendar(String filename) throws IOException, ParserException {
		InputStream in = ClassLoader.getSystemClassLoader().getResourceAsStream("icsFile/" + filename);
		if (in == null) {
			Assert.fail("Cannot load " + filename);
		}
		return new ICalendar.Builder().inputStream(in).build();	
	}
}