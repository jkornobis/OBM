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
package org.obm.push.bean;

import java.util.Map;

import com.google.common.collect.ImmutableMap;
import com.google.common.collect.ImmutableMap.Builder;

public enum MoveItemsStatus {
	
	INVALID_SOURCE_COLLECTION_ID("1"), //1 Invalid source collection ID.
	INVALID_DESTINATION_COLLECTION_ID("2"), //2 Invalid destination collection ID.
	SUCCESS("3"), // 3 Success
	SAME_SOURCE_AND_DESTINATION_COLLECTION_ID("4"), //4 Source and destination collection IDs are the same.
	SERVER_ERROR("5"), // 5 A failure occurred during the MoveItem operation.
	ITEM_ALREADY_EXISTS_AT_DESTINATION("6"), //6 An item with that name already exists at the destination.
	SOURCE_OR_DESTINATION_LOCKED("7");//7 Source or destination item was locked.

	private final String specificationValue;
	
	private MoveItemsStatus(String specificationValue) {
		this.specificationValue = specificationValue;
	}
	
	public String asSpecificationValue() {
		return specificationValue;
	}
	
	public static MoveItemsStatus fromSpecificationValue(String specificationValue) {
		if (specValueToEnum.containsKey(specificationValue)) {
			return specValueToEnum.get(specificationValue);
		}
		throw new IllegalArgumentException("No MoveItemsStatus for '" + specificationValue + "'");
	}
	
	private static Map<String, MoveItemsStatus> specValueToEnum;
		
	static {
		Builder<String, MoveItemsStatus> builder = ImmutableMap.builder();
		for (MoveItemsStatus status : values()) {
			builder.put(status.specificationValue, status);
		}
		specValueToEnum = builder.build();
	}
}
