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
package org.obm.push.bean.msmeetingrequest;

import java.util.Date;
import java.util.List;
import java.util.TimeZone;

import org.apache.commons.codec.binary.Base64;
import org.obm.push.utils.UserEmailParserUtils;

import com.google.common.base.Objects;
import com.google.common.base.Preconditions;
import com.google.common.base.Strings;


public class MSMeetingRequest {

	public static class MsMeetingRequestBuilder {
		public final static String DEFAULT_TIME_ZONE = 
				"xP///1IAbwBtAGEAbgBjAGUAIABTAHQAYQBuAGQAYQByAGQAIABUAGkAbQBlAAAAAAAAAAAAAAAAA" +
				"AAAAAAAAAAAAAAAAAoAAAAFAAMAAAAAAAAAAAAAAFIAbwBtAGEAbgBjAGUAIABEAGEAeQBsAGkAZw" +
				"BoAHQAIABUAGkAbQBlAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMAAAAFAAIAAAAAAAAAxP///w==";
		private boolean allDayEvent;
		private Date startTime;
		private Date dtStamp;
		private Date endTime;
		private MSMeetingRequestInstanceType instanceType;
		private String location;
		private String organizer;
		private Date recurrenceId;
		private Long reminder;
		private boolean responseRequested;
		private List<MSMeetingRequestRecurrence> recurrences;
		private MSMeetingRequestSensitivity sensitivity;
		private MSMeetingRequestIntDBusyStatus intDBusyStatus;
		private String timeZone;
		private String globalObjId;
		private List<MSMeetingRequestCategory> categories;
		
		public MsMeetingRequestBuilder allDayEvent(boolean allDayEvent) {
			this.allDayEvent = allDayEvent;
			return this;
		}
		
		public MsMeetingRequestBuilder startTime(Date startTime) {
			this.startTime = startTime;
			return this;
		}
		
		public MsMeetingRequestBuilder dtStamp(Date dtStamp) {
			this.dtStamp = dtStamp;
			return this;
		}
		
		public MsMeetingRequestBuilder endTime(Date endTime) {
			this.endTime = endTime;
			return this;
		}
		
		public MsMeetingRequestBuilder instanceType(MSMeetingRequestInstanceType instanceType) {
			this.instanceType = instanceType;
			return this;
		}
		
		public MsMeetingRequestBuilder location(String location) {
			this.location = location;
			return this;
		}
		
		public MsMeetingRequestBuilder organizer(String organizer) {
			this.organizer = organizer;
			return this;
		}
		
		public MsMeetingRequestBuilder recurrenceId(Date recurrenceId) {
			this.recurrenceId = recurrenceId;
			return this;
		}
		
		public MsMeetingRequestBuilder reminder(Long reminder) {
			this.reminder = reminder;
			return this;
		}
		
		public MsMeetingRequestBuilder reponseRequested(boolean responseRequested) {
			this.responseRequested = responseRequested;
			return this;
		}
		
		public MsMeetingRequestBuilder recurrences(List<MSMeetingRequestRecurrence> recurrences) {
			this.recurrences = recurrences;
			return this;
		}
		
		public MsMeetingRequestBuilder sensitivity(MSMeetingRequestSensitivity sensitivity) {
			this.sensitivity = sensitivity;
			return this;
		}
		
		public MsMeetingRequestBuilder intDBusyStatus(MSMeetingRequestIntDBusyStatus intDBusyStatus) {
			this.intDBusyStatus = intDBusyStatus;
			return this;
		}
		
		public MsMeetingRequestBuilder timeZone(TimeZone timeZone) {
			if (timeZone != null) {
				this.timeZone = timeZone.getID();
			}
			return this;
		}
		
		public MsMeetingRequestBuilder globalObjId(String globalObjId) {
			this.globalObjId = globalObjId;
			return this;
		}
		
		public MsMeetingRequestBuilder categories(List<MSMeetingRequestCategory> categories) {
			this.categories = categories;
			return this;
		}
		
		public MSMeetingRequest build() {
			Preconditions.checkNotNull(startTime, "The field startTime is required");
			Preconditions.checkNotNull(dtStamp, "The field dtStamp is required");
			Preconditions.checkNotNull(endTime, "The field endTime is required");
			Preconditions.checkNotNull(instanceType, "The field instanceType is required");
			
			if (!Strings.isNullOrEmpty(organizer)) {
				UserEmailParserUtils userEmailParserUtils = new UserEmailParserUtils();
				String login = userEmailParserUtils.getLogin(organizer);
				String domain = userEmailParserUtils.getDomain(organizer);
				organizer = login + "@" + domain;
			}

			if (recurrences != null && !recurrences.isEmpty()) {
				Preconditions.checkNotNull(recurrenceId, "The field recurrenceId is required");
			}

			if (sensitivity == null) {
				sensitivity = MSMeetingRequestSensitivity.NORMAL;
			}
			
			if (intDBusyStatus == null) {
				intDBusyStatus = MSMeetingRequestIntDBusyStatus.FREE;
			}
			
			if (timeZone != null) {
				timeZone = Base64.encodeBase64String(timeZone.getBytes());
			} else {
				timeZone = DEFAULT_TIME_ZONE;
			}

			Preconditions.checkNotNull(globalObjId, "The field GlobalObjId is required");
			
			return new MSMeetingRequest(allDayEvent, startTime, dtStamp, endTime, instanceType, location, 
					organizer, recurrenceId, reminder, responseRequested, recurrences, sensitivity, 
					intDBusyStatus, timeZone, globalObjId, categories);
		}
	}
	
	private final boolean allDayEvent;
	private final Date startTime;
	private final Date dtStamp;
	private final Date endTime;
	private final MSMeetingRequestInstanceType instanceType;
	private final String location;
	private final String organizer;
	private final Date recurrenceId;
	private final Long reminder;
	private final boolean responseRequested;
	private final List<MSMeetingRequestRecurrence> recurrences;
	private final MSMeetingRequestSensitivity sensitivity;
	private final MSMeetingRequestIntDBusyStatus intDBusyStatus;
	private final String timeZoneInBase64;
	private final String globalObjId;
	private final List<MSMeetingRequestCategory> categories;
	
	private MSMeetingRequest(boolean allDayEvent, Date startTime, Date dtStamp, Date endTime, MSMeetingRequestInstanceType instanceType, 
			String location, String organizer, Date recurrenceId, Long reminder, boolean responseRequested,
			List<MSMeetingRequestRecurrence> recurrences, MSMeetingRequestSensitivity sensitivity, 
			MSMeetingRequestIntDBusyStatus intDBusyStatus, String timeZoneInBase64, String globalObjId, 
			List<MSMeetingRequestCategory> categories) {
		
		super();
		this.allDayEvent = allDayEvent;
		this.startTime = startTime;
		this.dtStamp = dtStamp;
		this.endTime = endTime;
		this.instanceType = instanceType;
		this.location = location;
		this.organizer = organizer;
		this.recurrenceId = recurrenceId;
		this.reminder = reminder;
		this.responseRequested = responseRequested;
		this.recurrences = recurrences;
		this.sensitivity = sensitivity;
		this.intDBusyStatus = intDBusyStatus;
		this.timeZoneInBase64 = timeZoneInBase64;
		this.globalObjId = globalObjId;
		this.categories = categories;
	}

	public boolean isAllDayEvent() {
		return allDayEvent;
	}

	public Date getStartTime() {
		return startTime;
	}

	public Date getDtStamp() {
		return dtStamp;
	}

	public Date getEndTime() {
		return endTime;
	}

	public MSMeetingRequestInstanceType getInstanceType() {
		return instanceType;
	}

	public String getLocation() {
		return location;
	}

	public String getOrganizer() {
		return organizer;
	}

	public Date getRecurrenceId() {
		return recurrenceId;
	}

	public Long getReminder() {
		return reminder;
	}

	public boolean isResponseRequested() {
		return responseRequested;
	}

	public List<MSMeetingRequestRecurrence> getRecurrences() {
		return recurrences;
	}

	public MSMeetingRequestSensitivity getSensitivity() {
		return sensitivity;
	}

	public MSMeetingRequestIntDBusyStatus getIntDBusyStatus() {
		return intDBusyStatus;
	}

	public String getTimeZoneInBase64() {
		return timeZoneInBase64;
	}
	
	public String getGlobalObjId() {
		return globalObjId;
	}

	public List<MSMeetingRequestCategory> getCategories() {
		return categories;
	}

	@Override
	public final int hashCode(){
		return Objects.hashCode(allDayEvent, startTime, dtStamp, endTime, 
				instanceType, location, organizer, recurrenceId, reminder, 
				responseRequested, recurrences, sensitivity, intDBusyStatus, timeZoneInBase64, globalObjId, categories);
	}
	
	@Override
	public final boolean equals(Object object){
		if (object instanceof MSMeetingRequest) {
			MSMeetingRequest that = (MSMeetingRequest) object;
			return Objects.equal(this.allDayEvent, that.allDayEvent)
				&& Objects.equal(this.startTime, that.startTime)
				&& Objects.equal(this.dtStamp, that.dtStamp)
				&& Objects.equal(this.endTime, that.endTime)
				&& Objects.equal(this.instanceType, that.instanceType)
				&& Objects.equal(this.location, that.location)
				&& Objects.equal(this.organizer, that.organizer)
				&& Objects.equal(this.recurrenceId, that.recurrenceId)
				&& Objects.equal(this.reminder, that.reminder)
				&& Objects.equal(this.responseRequested, that.responseRequested)
				&& Objects.equal(this.recurrences, that.recurrences)
				&& Objects.equal(this.sensitivity, that.sensitivity)
				&& Objects.equal(this.intDBusyStatus, that.intDBusyStatus)
				&& Objects.equal(this.timeZoneInBase64, that.timeZoneInBase64)
				&& Objects.equal(this.globalObjId, that.globalObjId)
				&& Objects.equal(this.categories, that.categories);
		}
		return false;
	}
}