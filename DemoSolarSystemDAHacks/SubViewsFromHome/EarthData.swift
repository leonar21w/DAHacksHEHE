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
			VStack{
				Text(vm.data.address)
					.foregroundStyle(Color.white)
			}
		}.navigationBarHidden(true)
	}
}

#Preview {
    EarthData()
}
