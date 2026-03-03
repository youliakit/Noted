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

class NotesViewModel: ObservableObject {

	@Published var notes: [Note] = []
	@Published var editingNote: Note.ID?

	// Find url for our document's folder
	private var documentDirectory: URL {
		try! FileManager.default
			.url(
				for: .documentDirectory,
				in: .userDomainMask,
				appropriateFor: nil,
				create: true
			)
	}

	/// Append file name and extension to our documentDirectory URL
	/// Our app will store notes in a JSON file called 'notes'
	private var notesFile: URL {
		documentDirectory
			.appendingPathComponent("notes")
			.appendingPathExtension(for: .json)
	}

	/// Creates a new note, then updates the navigation state so that the `EditNoteView` is displayed for the new note.
	func createNote() {
		let note = Note(id: UUID(), title: "New Note", content: "")
		notes.append(note)

		// Update state to show the EditNoteView for the new note
		editingNote = note.id
	}

	/// Deletes one or more notes. This is used to enable SwiftUI’s built-in delete functionality.
	/// - Parameter indexSet: Indices in the `notes` array for the notes being removed.
	func handleDelete(_ indexSet: IndexSet) {
		notes.remove(atOffsets: indexSet)
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
