//
//  MarsData.swift
//  DemoSolarSystemDAHacks
//
//  Created by Leonard on 10/25/24.
//

import SwiftUI

struct MarsData: View {
	
	@StateObject var horizonvm = EarthMarsDistanceFetcher()
	
	@State private var isVisible = false
	
	var body: some View {
		ZStack {
			LoadBackground()
			
			ZStack {
				PlanetSceneView(typeofView: "earthTexture")
					.frame(width: 700 , height: 700)
					.clipShape(Circle())
					.offset(x: 150,y: -250)
				
				cat()
					.offset(x: 130, y: 350)
				PlanetSceneView(typeofView: "marstexture")
					.frame(width: 700 , height: 700)
					.clipShape(Circle())
					.offset(x: -150,y: 250)
			}
			TransparentView()
			
			VStack{
				Text("Time to get there?")
					.font(.title)
					.fontWeight(.bold)
					.foregroundStyle(Color.white)
				
				ForEach(horizonvm.platypuswearinghat(), id: \.0) { data in
					VStack(alignment: .leading){
						Text("Distance")
							.font(.subheadline)
							.fontWeight(.semibold)
							.foregroundStyle(Color.white)
						Text("\(data.0) km from Earth")
							.foregroundStyle(Color.white)
						Text("Getting there in..")
							.font(.subheadline)
							.fontWeight(.semibold)
							.foregroundStyle(Color.white)
						Text("\(data.1) days and \(data.2) hours")
							.foregroundStyle(Color.white)
					}
					.padding()
					.background(RoundedRectangle(cornerRadius: 20).fill(Color.white.opacity(0.3)))
					.padding()
				}
				
				//CHANGE THIS WITH DATA
				VStack(alignment: .center){
					Text("! BEWARE !")
						.font(.subheadline)
						.fontWeight(.semibold)
						.foregroundStyle(Color.white)
					Text("Just remember that the suns rays there are stronger D:")
						.font(.caption)
						.fontWeight(.light)
						.foregroundStyle(Color.white)
						Text("Temperatures On the bright side and dark side fluctuate drastically")
							.font(.caption)
							.fontWeight(.light)
							.foregroundStyle(Color.white)
					VStack{
						
						HStack {
							Text("Daytime")
								.font(.caption)
								.fontWeight(.semibold)
								.foregroundStyle(Color.white)
							Text("121°C")
								.font(.caption)
								.fontWeight(.light)
								.foregroundStyle(Color.white)
						}
						HStack {
							Text("NightTime")
								.font(.caption)
								.fontWeight(.semibold)
								.foregroundStyle(Color.white)
							Text("-133°C")
								.font(.caption)
								.fontWeight(.light)
								.foregroundStyle(Color.white)
						}
						
					}
				}
				
			}
			.opacity(isVisible ? 1 : 0)
			.animation(.easeIn(duration: 1.5), value: isVisible)
		}.navigationBarHidden(true)
			.onAppear {
				isVisible = true
			}
	}
}

#Preview {
	MoonData()
}
