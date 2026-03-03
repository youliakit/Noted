//
//  Note.swift
//  Noted
//
//  Created by 𝒴𝑜𝓊𝓁𝒾𝒶 𝒯𝒾𝑔𝓇𝒶𝓃𝓎𝒶𝓃 on 03.03.26.
//

import Foundation

struct Note: Codable, Hashable, Identifiable {
	let id: UUID
	var title: String
	var content: String
}
