//
//  ContentView.swift
//  Noted
//
//  Created by 𝒴𝑜𝓊𝓁𝒾𝒶 𝒯𝒾𝑔𝓇𝒶𝓃𝓎𝒶𝓃 on 03.03.26.
//

import SwiftUI

struct Welcome: View {
	var body: some View {
		NavigationStack {
			ZStack {

				// Background image
				Image("Welcome")
					.resizable()
					.scaledToFill()
					.ignoresSafeArea()

				// Bottom card
				VStack(spacing: 24) {
					Text("Your ideas. Noted.")
						.font(.custom("Lipstick Rage", size: 46))
						.multilineTextAlignment(.center)

					NavigationLink("Get started✨") {
						NotesView()
					}
					.buttonStyle(.borderedProminent)
					.tint(Color.pink.opacity(0.4))
					.font(.custom("Lipstick Rage", size: 20))
				}
				.padding(.vertical, 40)
				.padding(.horizontal, 24)
				.frame(maxWidth: 420)
				.background(
					Color.white.opacity(0.85)
						.clipShape(
							UnevenRoundedRectangle(
								topLeadingRadius: 50,
								bottomLeadingRadius: 50,
								bottomTrailingRadius: 50,
								topTrailingRadius: 50
							)

						)
				)
				.frame(maxHeight: .infinity, alignment: .bottom)
				.padding(.bottom, 130)
			}
		}
	}
}

#Preview {
	Welcome()
}
