<table style="width:80%; border:1px solid #000; border-collapse:collapse;background:#EFF0F2;font-size:12px;">
    <tr>
        <th style="text-align:center; background-color: #509CBC; color:#FFF; font-size:14px" colspan="2">
          New appointment
        </th>
    </tr>
    <tr>
        <td colspan="2">You are invited to participate to this appointment</td>
    </tr>
    <tr>
        <td style="text-align:right;width:20%;padding-right:1em;">Subject</td><td style="font-weight:bold;">${subject}</td>
    </tr>
    <tr>
        <td style="text-align:right;padding-right:1em;">From</td><td style="font-weight:bold;">${start?string.medium_short}</td>
    </tr>
    <tr>
        <td style="text-align:right;padding-right:1em;">To</td><td style="font-weight:bold;">${end?string.medium_short}</td>
    </tr>
    <tr>
        <td style="text-align:right;padding-right:1em;">Location</td><td style="font-weight:bold;">${location}</td>
    </tr>
    <tr>
        <td style="text-align:right;padding-right:1em;">Organizer</td><td style="font-weight:bold;">${organizer}</td>
    </tr>
    <tr>
        <td style="text-align:right;padding-right:1em;">Created by</td><td style="font-weight:bold;">${creator}</td>
    </tr>
    <tr valign="top">
        <td style="text-align:right;padding-right:1em;">Attendee(s)</td><td style="font-weight:bold;">${attendees}</td>
    </tr>
	<tr>
    	<td colspan="2">
      		<strong>NB : </strong>If you're using the Thunderbird extension or ActiveSync, you must synchronize to view this appointment.
    	</td>
	</tr>
    <tr>
        <td style="text-align:right;" colspan="2">
          <a href="${host}calendar/calendar_index.php?action=detailconsult&calendar_id=${calendarId}">Details</a>
        </td>
    </tr>
</table>
