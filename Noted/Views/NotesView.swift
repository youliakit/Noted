//
//  NotesView.swift
//  Noted
//
//  Created by 𝒴𝑜𝓊𝓁𝒾𝒶 𝒯𝒾𝑔𝓇𝒶𝓃𝓎𝒶𝓃 on 03.03.26.
//


import SwiftUI

struct NotesView: View {
  @StateObject var viewModel = NotesViewModel()

  var body: some View {
	NavigationView {
	  List {
		ForEach(viewModel.notes) { note in
		  // Each note gets a NavigationLink that points to the EditNoteView for that note. We can open the EditNoteView programmatically by setting the `editingNote` property of the view model to this note’s ID.
			NavigationLink(value: note) {
				Text(note.title)
			}
			.navigationDestination(for: Note.self) { note in
				EditNoteView(note: binding(for: note))
			}
		}
		// The onDelete(perform:) modifier in SwiftUI enables the ability to delete a note from the list by swiping left on it and tapping “Delete”. The actual deletion is carried out by the handleDelete(_:) method from the NotesViewModel.
		.onDelete(perform: viewModel.handleDelete(_:))
	  }
	  .navigationBarItems(trailing: Button(action: viewModel.createNote) {
		Label("New Note", systemImage: "plus.circle.fill")
	  })
	  .navigationTitle("My Notes")
	}
	// MARK: - Persistence




  }

  /// Returns the given note as a binding. This is required because the `EditNoteView` requires a binding so that the note can be edited, and the SwiftUI `ForEach` element doesn’t provide a binding.
  private func binding(for note: Note) -> Binding<Note> {
	guard let index = viewModel.notes.firstIndex(of: note) else {
	  fatalError("Failed to find note: \(note)")
	}
	return $viewModel.notes[index]
  }
}

struct NotesView_Previews: PreviewProvider {
  static var previews: some View {
	NotesView()
  }
}
