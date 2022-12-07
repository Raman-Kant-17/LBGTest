//
//  HomeViewModel.swift
//  LBG Test
//
//  Created by Raman Kant on 07/12/22.
//

import Foundation

class MyArtResult: ObservableObject {
    var page: Int = 1
    var size: Int = 15
    var isCompleted: Bool = false
    @Published var error: Error?
    @Published var arrayArts: [ArtInfo]?
}

class HomeViewModel {
    
    var myArtResult: MyArtResult
    var isVehicleChanged = false
    
    init(_myArtResult: MyArtResult) {
        self.myArtResult = _myArtResult
    }
    
    func fetchArts() {

        guard let url = URL(string:ServicesConstant.mainUrl + ServicesConstant.artworks) else { return }
        let queryItems = [
            URLQueryItem(name: "fields", value: "id,title,image_id"),
            URLQueryItem(name: "page", value: "\(self.myArtResult.page)"),
            URLQueryItem(name: "size", value: "\(self.myArtResult.size)")
        ]
        let queryUrl = url.appending(queryItems: queryItems)
        HTTPUtils.shared.requestGet(url: queryUrl, method: ._get, type: ArtResponse.self) { result, error in
            if let _error = error {
                self.myArtResult.error = _error
            }
            else{
                if (result?.data ?? []).isEmpty {
                    self.myArtResult.isCompleted = true
                }
                self.myArtResult.error = nil
                self.myArtResult.arrayArts == nil ? (self.myArtResult.arrayArts = result?.data ?? []) : (self.myArtResult.arrayArts?.append(contentsOf: result?.data ?? []))
            }
        }
    }
}
