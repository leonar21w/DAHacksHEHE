//
//  MoonData.swift
//  DemoSolarSystemDAHacks
//
//  Created by Leonard on 10/25/24.
//

import SwiftUI

struct MoonData: View {
	var body: some View {
		ZStack {
			LoadBackground()
			TransparentView()
			VStack{
				Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
			}
		}.navigationBarHidden(true)
	}
}

#Preview {
    MoonData()
}
