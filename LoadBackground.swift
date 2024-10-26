//
//  LoadBackground.swift
//  DemoSolarSystemDAHacks
//
//  Created by Leonard on 10/25/24.
//

import SwiftUI

struct LoadBackground: View {
	@StateObject var homeBackground = HomeImage()
    var body: some View {
		CacheAsyncImage(
			url:
				URL(string: homeBackground.homepageImageData.url!)
			?? URL(string: "https://apod.nasa.gov/apod/image/2410/NGC6752_DiFusco.jpg")!) { phase in
			switch phase {
			case .empty:
				// Show a placeholder image when the content is loading
				Image("NASAIMAGE")
					.resizable()
					.scaledToFill()
					.ignoresSafeArea()
					.overlay(Color.black.opacity(0.5))

			case .success(let image):
				// Show the successfully loaded image
				image
					.resizable()
					.scaledToFill()
					.ignoresSafeArea()
					.overlay(Color.black.opacity(0.5))

			case .failure:
				// Show the placeholder image in case of an error
				Image("NASAIMAGE")
					.resizable()
					.scaledToFill()
					.ignoresSafeArea()
					.overlay(Color.black.opacity(0.5))

			@unknown default:
				// Handle unexpected cases
				Image("NASAIMAGE")
					.resizable()
					.scaledToFill()
					.ignoresSafeArea()
					.overlay(Color.black.opacity(0.3))
			}
		}

    }
}

#Preview {
    LoadBackground()
}
