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

import static org.fest.assertions.api.Assertions.assertThat;

import org.joda.time.DateTime;
import org.joda.time.DateTimeZone;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.obm.filter.SlowFilterRunner;
import org.obm.push.protocol.bean.ASSystemTime;
import org.obm.push.utils.type.UnsignedShort;

import com.google.common.primitives.Bytes;

@RunWith(SlowFilterRunner.class)
public class SystemTimeEncoderTest {

	private SystemTimeEncoder systemTimeEncoder;

	@Before
	public void setUp() {
		systemTimeEncoder = new SystemTimeEncoder();
	}
	
	@Test
	public void testEncodeTimeZeroDate() {
		ASSystemTime systemTime = new ASSystemTime.FromDateBuilder().dateTime(new DateTime(0)).build();
		byte[] asBinary = systemTimeEncoder.toByteArray(systemTime);
		
		byte[] year = byteArrayOfUnsignedShort(0);
		byte[] month = byteArrayOfUnsignedShort(0);
		byte[] dayOfWeek = byteArrayOfUnsignedShort(0);
		byte[] weekOfMonth = byteArrayOfUnsignedShort(0);
		byte[] hour = byteArrayOfUnsignedShort(0);
		byte[] minute = byteArrayOfUnsignedShort(0);
		byte[] second = byteArrayOfUnsignedShort(0);
		byte[] millis = byteArrayOfUnsignedShort(0);
		
		byte[] expectedBinary = Bytes.concat(year, month, dayOfWeek, weekOfMonth, hour, minute, second, millis);

		assertThat(asBinary).isEqualTo(expectedBinary);
	}

	@Test
	public void testEncodeLastMillisOf2012Date() {
		ASSystemTime systemTime = new ASSystemTime.FromDateBuilder()
			.dateTime(new DateTime(DateTime.parse("2012-12-31T23:59:59.999+00"), DateTimeZone.UTC)).build();
		
		byte[] asBinary = systemTimeEncoder.toByteArray(systemTime);
		
		byte[] year = byteArrayOfUnsignedShort(2012);
		byte[] month = byteArrayOfUnsignedShort(12);
		byte[] dayOfWeek = byteArrayOfUnsignedShort(1);
		byte[] weekOfMonth = byteArrayOfUnsignedShort(5);
		byte[] hour = byteArrayOfUnsignedShort(23);
		byte[] minute = byteArrayOfUnsignedShort(59);
		byte[] second = byteArrayOfUnsignedShort(59);
		byte[] millis = byteArrayOfUnsignedShort(999);
		
		byte[] expectedBinary = Bytes.concat(year, month, dayOfWeek, weekOfMonth, hour, minute, second, millis);

		assertThat(asBinary).isEqualTo(expectedBinary);
	}

	@Test
	public void testEncodeFirstMillisOf2015Date() {
		ASSystemTime systemTime = new ASSystemTime.FromDateBuilder()
			.dateTime(new DateTime(DateTime.parse("2015-01-01T00:00:00.000+00"), DateTimeZone.UTC)).build();

		byte[] asBinary = systemTimeEncoder.toByteArray(systemTime);
		
		byte[] year = byteArrayOfUnsignedShort(2015);
		byte[] month = byteArrayOfUnsignedShort(1);
		byte[] dayOfWeek = byteArrayOfUnsignedShort(4);
		byte[] weekOfMonth = byteArrayOfUnsignedShort(1);
		byte[] hour = byteArrayOfUnsignedShort(0);
		byte[] minute = byteArrayOfUnsignedShort(0);
		byte[] second = byteArrayOfUnsignedShort(0);
		byte[] millis = byteArrayOfUnsignedShort(0);
		
		byte[] expectedBinary = Bytes.concat(year, month, dayOfWeek, weekOfMonth, hour, minute, second, millis);

		assertThat(asBinary).isEqualTo(expectedBinary);
	}

	private byte[] byteArrayOfUnsignedShort(int unsignedShortValue) {
		return UnsignedShort.checkedCast(unsignedShortValue).toByteArray();
	}

}