//
//  constant.swift
//  MediaSoft
//
//  Created by Айрат Туктамышев on 03/07/2019.
//  Copyright © 2019 Айрат Туктамышев. All rights reserved.
//

import Foundation



struct JsonReqStr {
    
    var http:String = "https://pixabay.com/api/?"
    var apikey:String = "key=12917251-47adbb1a67c6a942b61974134"
    var q:String=" "
    var lang:String="ru"
    var image_type:String="all"
    var orientation:String="all"
    var category:String=" "
    var min_width:Int?
    var min_height:Int?
    var colors:String=" "
    var editor_choise:Bool?
    
    var req:String?
    
    public func isEmpty()->Bool
    {
        if (self.q == " "){
            return false}
        
        if !(self.q == " "){
            return true}
        
        return false
    }
    
    public func Result()->URLRequest {
        var result:String=""
        
        result+=self.http
        result+=self.apikey
        result+="&q="+self.q
        result+="&lang="+self.lang
        result+="&image_type="+self.image_type
        if !(self.category == " "){
        result+="&category="+self.category
        }
        
        result+="&orientation="+self.orientation
        
        print(result)
        
        let request =  URLRequest(url: URL(string:result)!)
        return request
        }
}
