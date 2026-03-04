//
//  NotesView.swift
//  Noted
//
//  Created by 𝒴𝑜𝓊𝓁𝒾𝒶 𝒯𝒾𝑔𝓇𝒶𝓃𝓎𝒶𝓃 on 03.03.26.
//


import SwiftUI

struct NotesView: View {
	@StateObject var viewModel = NotesViewModel()

	@State private var isPresenting: Bool = false
	@State private var selectedNoteID: UUID?

	var body: some View {

		let layout = [
			GridItem(.flexible(minimum: 40)),
			GridItem(.flexible(minimum: 40)) ]

		NavigationStack {
			ScrollView {
				LazyVGrid(columns: layout) {
					ForEach(viewModel.notes, id: \.id) { note in
						ZStack(alignment: .topTrailing) {
							ZStack {
								RoundedRectangle(cornerRadius: 20, style: .continuous)
									.fill(Color.white)
									.frame(width: 200, height: 100)
									.shadow(radius: 10)

								Text(note.title == "" ? "Make a new note" : note.title)
									.font(.custom("Lipstick Rage", size: 20))
									.foregroundColor(.pink)
									.opacity(0.5)
							}
							.onTapGesture {
								selectedNoteID = note.id
								isPresenting = true
							}
							Button {
								viewModel.handleDelete(note)
							} label: {
								Image(systemName: "trash.fill") .foregroundColor(.red) .padding(6)
							}
						}
					}
				}
			}
			.sheet(isPresented: $isPresenting) {
				if let id = selectedNoteID,
				   let index = viewModel.notes.firstIndex(where: { $0.id == id }) {
					EditNoteView(note: $viewModel.notes[index])
				}
			}
			.navigationBarItems(trailing: Button {
				let newNote = viewModel.createNote()
				selectedNoteID = newNote.id
				isPresenting = true
			} label: {
				Image("new")
					.resizable()
					.scaledToFit()
					.frame(width: 36, height: 36)
			})
			.navigationTitle("My Notes")
		}
		// MARK: - Persistence
		// Perform an action when the modified view appears
		.onAppear {
			try! viewModel.load()
		}

		// run the provided closure whenever 'notes' variable's value is changed
		.onChange(of: viewModel.notes) {
			try? viewModel.save()
		}
	}
}

struct NotesView_Previews: PreviewProvider {
	static var previews: some View {
		NotesView()
	}
}
