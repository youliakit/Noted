//
//  NotesViewModel.swift
//  Noted
//
//  Created by 𝒴𝑜𝓊𝓁𝒾𝒶 𝒯𝒾𝑔𝓇𝒶𝓃𝓎𝒶𝓃 on 03.03.26.
//

import Combine
import Foundation
import SwiftUI

class NotesViewModel: ObservableObject {

  @Published var notes: [Note] = []
  @Published var editingNote: Note.ID?

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





}
