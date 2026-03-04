//
//  NotesViewModel.swift
//  Noted
//
//  Created by 𝒴𝑜𝓊𝓁𝒾𝒶 𝒯𝒾𝑔𝓇𝒶𝓃𝓎𝒶𝓃 on 03.03.26.
//

import Combine
import Foundation
import SwiftUI
internal import UniformTypeIdentifiers


// Class lets us to have a single, observable instance
class NotesViewModel: ObservableObject {

	// Published lets us to automatically react on changes
	@Published var notes: [Note] = []    // our notes

	private var documentDirectory: URL {
		try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
	}

	/// Append file name and extension to our documentDirectory URL
	/// Our app will store notes in a JSON file called 'notes'
	private var notesFile: URL {
		documentDirectory
			.appendingPathComponent("notes")
			.appendingPathExtension(for: .json)
	}


	/// Creates a new note
	func createNote() -> Note {
		let note = Note(id: UUID(), title: "", content: "")
		notes.append(note)
		return note
	}

	func handleDelete(_ note: Note) {
		notes.removeAll { $0.id == note.id }
	}

	// MARK: - Persistence
	func save() throws {
		let data = try JSONEncoder().encode(notes) // encoding the notes as a data
		try data.write(to: notesFile) // write our encoded data to a file
	}

	/// Reversing the process of saving data: we need to read data from the file and decode it to produce Note types
	func load() throws {
		// verify that the file exists before we try to read it
		guard FileManager.default.isReadableFile(atPath: notesFile.path) else { return }
		let data = try Data(contentsOf: notesFile)
		notes = try JSONDecoder().decode([Note].self, from: data)
	}
}
