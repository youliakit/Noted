//
//  EditNoteView.swift
//  Noted
//
//  Created by 𝒴𝑜𝓊𝓁𝒾𝒶 𝒯𝒾𝑔𝓇𝒶𝓃𝓎𝒶𝓃 on 03.03.26.
//

import SwiftUI

struct EditNoteView: View {
	@Binding var note: Note

	var body: some View {
		Form {
			Section(header: Text("Title")) {
				TextField("Title", text: $note.title)
			}
			Section(header: Text("Note")) {
				TextEditor(text: $note.content)
			}
		}
		.navigationTitle("Edit")
	}
}

struct EditNoteView_Previews: PreviewProvider {
	@State private static var note = Note(id: UUID(), title: "New Note", content: "This is some content...")

	static var previews: some View {
		NavigationView {
			EditNoteView(note: $note)
		}
	}
}
