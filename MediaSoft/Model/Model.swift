//
//  Model.swift
//  MediaSoft
//
//  Created by Айрат Туктамышев on 01/07/2019.
//  Copyright © 2019 Айрат Туктамышев. All rights reserved.
//

import Foundation

struct ImageJSON: Decodable {
    var totalHits:Int?
    let hits:[Hits]
}

struct Hits:Decodable{
    var largeImageURL:String?
    var webformatHeight:Int?
    var webformatWidth: Int?
    var likes: Int?
    var imageWidth: Int?
    var id: Int?
    var user_id: Int?
    var views: Int?
    var comments: Int?
    var pageURL: String?
    var imageHeight : Int?
    var webformatURL : String?
    var type :  String?
    var previewHeight : Int?
    var tags :  String?
    var downloads : Int?
    var user :  String?
    var favorites : Int?
    var imageSize : Int?
    var previewWidth : Int?
    var userImageURL :  String?
    var previewURL :  String?
}


