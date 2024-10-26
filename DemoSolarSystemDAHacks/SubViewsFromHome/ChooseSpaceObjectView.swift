//
//  ChooseSpaceObjectView.swift
//  DemoSolarSystemDAHacks
//
//  Created by Leonard on 10/25/24.
//

import SwiftUI

struct ChooseSpaceObjectView: View {
    var body: some View {
		ZStack {
			LoadBackground()
			TransparentView()
			VStack (alignment: .leading){
				HStack {
					Text("Choose a Celestial body :)")
						.font(.title)
						.fontWeight(.bold)
						.foregroundStyle(Color.white.opacity(0.8))
						.padding(.horizontal, 20)
					
				}
				HStack {
					NavigationLink(destination: EarthData()) {
						BoxForChoosingPlanetView(celestialObject: "Earth", typeOfView: "earthTexture")
							.padding(.horizontal, 10)
					}
					NavigationLink(destination: MoonData()) {
						BoxForChoosingPlanetView(celestialObject: "Moon", typeOfView: "MoonTexture")
							.padding(.horizontal, 10)
					}
					
				}
				HStack {
					NavigationLink(destination: MarsData()) {
						BoxForChoosingPlanetView(celestialObject: "Mars", typeOfView: "marstexture")
							.padding(.horizontal, 10)
						
					}
				}

			}
			Spacer()
			.navigationBarHidden(true)
		}
    }
}

#Preview {
    ChooseSpaceObjectView()
}
