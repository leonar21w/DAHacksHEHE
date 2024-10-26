//
//  MarsData.swift
//  DemoSolarSystemDAHacks
//
//  Created by Leonard on 10/25/24.
//

import SwiftUI

struct MarsData: View {
	var body: some View {
		ZStack {
			LoadBackground()
			TransparentView()
			VStack{
				Text("not done 🥲")
					.font(.title)
					.foregroundStyle(Color.white)
				Image("hehenotdone")
					.resizable()
					.scaledToFit()
					.frame(width: 300, height: 300)
			}
		}.navigationBarHidden(true)
	}
}


#Preview {
    MarsData()
}
