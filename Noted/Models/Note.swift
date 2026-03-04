//
//  Note.swift
//  Noted
//
//  Created by 𝒴𝑜𝓊𝓁𝒾𝒶 𝒯𝒾𝑔𝓇𝒶𝓃𝓎𝒶𝓃 on 03.03.26.
//

import Foundation

struct Note: Codable, Hashable, Identifiable {
	let id: UUID // each note has a unique ID
	var title: String
	var content: String
}
