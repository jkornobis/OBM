/* ***** BEGIN LICENSE BLOCK *****
 * Version: GPL 2.0
 *
 * The contents of this file are subject to the GNU General Public
 * License Version 2 or later (the "GPL").
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Initial Developer of the Original Code is
 *   obm.org project members
 *
 * ***** END LICENSE BLOCK ***** */

package org.obm.caldav.server.propertyHandler.impl;

import org.obm.caldav.server.IBackend;
import org.obm.caldav.server.StatusCodeConstant;
import org.obm.caldav.server.exception.AppendPropertyException;
import org.obm.caldav.server.propertyHandler.CalendarMultiGetPropertyHandler;
import org.obm.caldav.server.propertyHandler.DavPropertyHandler;
import org.obm.caldav.server.share.CalendarResourceICS;
import org.w3c.dom.CDATASection;
import org.w3c.dom.Element;

public class CalendarData extends DavPropertyHandler implements
		CalendarMultiGetPropertyHandler {

	@Override
	public void appendCalendarMultiGetPropertyValue(Element prop, IBackend proxy,
			CalendarResourceICS icsEvent) throws AppendPropertyException {
		if (icsEvent.getIcs() == null || "".equals(icsEvent.getIcs())) {
			throw new AppendPropertyException(StatusCodeConstant.SC_NOT_FOUND);
		}
		
		Element val = appendElement(prop, "calendar-data", ""); 
		CDATASection cdata = prop.getOwnerDocument().createCDATASection(
				icsEvent.getIcs());
		val.appendChild(cdata);
	}
}
