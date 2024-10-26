//
//  EarthData.swift
//  DemoSolarSystemDAHacks
//
//  Created by Leonard on 10/25/24.
//

import SwiftUI

struct EarthData: View {
	
	@StateObject var vm = WeatherViewVM()
	
	var body: some View {
		ZStack {
			LoadBackground()
			TransparentView()
			VStack {
				PlanetSceneView(typeofView: "earthTexture")
					.frame(width: 350 , height: 350)
					.clipShape(Circle())
					.offset(y: -100)
			}
			
			VStack(alignment: .center){
				Text(vm.data.address)
					.font(.title)
					.fontWeight(.semibold)
					.foregroundStyle(Color.white)
				Text("\(Int(ceil(vm.data.currentConditions.feelslike)))°")
					.font(.system(size: 80))
					.fontWeight(.regular)
					.foregroundStyle(Color.white)
				Text("\(vm.data.currentConditions.conditions)")
					.font(.title)
					.fontWeight(.medium)
					.foregroundStyle(Color.white)
				
				HStack{
					Text("Humidity")
						.font(.subheadline)	.fontWeight(.medium)
						.foregroundStyle(Color.white)
					
					
					Text("\(vm.data.currentConditions.humidity)")
						.font(.subheadline)
						.fontWeight(.medium)
						.foregroundStyle(Color.white)
					
				}
				
				
			}
		}.navigationBarHidden(true)
	}
}

#Preview {
    EarthData()
		.environmentObject(HomeImage())
}
