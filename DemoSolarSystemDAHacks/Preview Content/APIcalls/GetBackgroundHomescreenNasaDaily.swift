//
//  GetBackgroundHomescreenNasaDaily.swift
//  DemoSolarSystemDAHacks
//
//  Created by Leonard on 10/25/24.
//
import Foundation
@MainActor
class HomeImage: ObservableObject {
	@Published var homepageImageData: HomeImageStruct = HomeImageStruct(url: "", title: "", copyright: "")

	init() {
		Task {
			do {
				self.homepageImageData = try await getRequest()
				print("sucess")
				print("\(homepageImageData.url!)")
			} catch {
				print("Error fetching data: \(error)")
			}
		}
	}
	
	func getRequest() async throws -> HomeImageStruct {
		let jsonDecoder = JSONDecoder()
		jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
		
		guard let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=\(nasaapi)") else {
			throw URLError(.badURL)
		}
		
		let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
		
		guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
			throw URLError(.badServerResponse)
		}
		
		let decodedData = try jsonDecoder.decode(HomeImageStruct.self, from: data)
		return decodedData
	}
	
}

struct HomeImageStruct: Codable {
	let url: String?
	let title: String
	let copyright: String
}
