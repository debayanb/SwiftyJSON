//
//  SequenceTypeTests.swift
//
//  Copyright (c) 2014 Pinglin Tang
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import XCTest
import Foundation

@testable import SwiftyJSON

class SequenceTypeTests: XCTestCase {

// GENERATED: allTests required for Swift 3.0
    static var allTests : [(String, (SequenceTypeTests) -> () throws -> Void)] {
        return [
            ("testJSONFile", testJSONFile),
            ("testArrayAllNumber", testArrayAllNumber),
            ("testArrayAllBool", testArrayAllBool),
            ("testArrayAllString", testArrayAllString),
            ("testArrayWithNull", testArrayWithNull),
            ("testArrayAllDictionary", testArrayAllDictionary),
            ("testDictionaryAllNumber", testDictionaryAllNumber),
            ("testDictionaryAllBool", testDictionaryAllBool),
            ("testDictionaryAllString", testDictionaryAllString),
            ("testDictionaryWithNull", testDictionaryWithNull),
            ("testDictionaryAllArray", testDictionaryAllArray),
        ]
    }
// END OF GENERATED CODE
    func testJSONFile() {
        do {
            let testData = try Data(contentsOf: URL(fileURLWithPath: "Tests/SwiftyJSONTests/Tests.json"))
            let json = JSON(data:testData)
            var ind = 0
            for (_, sub) in json {
                switch (ind)  {
                case 0:
                    let case0 = sub["id_str"].rawString()!
                    XCTAssertEqual(case0, "240558470661799936")
                    ind += 1
                case 1:
                    let case1 = sub["id_str"].rawString()!
                    XCTAssertEqual(case1, "240556426106372096")
                    ind += 1
                case 2:
                    let case2 = sub["id_str"].rawString()!
                    XCTAssertEqual(case2, "240539141056638977")
                default:
                    XCTFail("testJSONFile failed, index not found")
                    break
                }
            }
        }
        catch {
            XCTFail("Failed to read in the test data")
        }
    }
    
    func testArrayAllNumber() {
        var json:JSON = [1,2.0,3.3,123456789,987654321.123456789]
        XCTAssertEqual(json.count, 5)

        var index = 0
        var array = [NSNumber]()
        for (i, sub) in json {
            XCTAssertEqual(sub, json[index])
            let ind: Int? = index
            XCTAssertEqual(i, "\(ind)")
            array.append(sub.number!)
            index += 1
        }
        XCTAssertEqual(index, 5)
        XCTAssertEqual(array, [1,2.0,3.3,123456789,987654321.123456789])
    }
    
    func testArrayAllBool() {
        var json:JSON = JSON([true, false, false, true, true])
        XCTAssertEqual(json.count, 5)
        
        var index = 0
        var array = [Bool]()
        for (i, sub) in json {
            XCTAssertEqual(sub, json[index])
            let ind: Int? = index
            XCTAssertEqual(i, "\(ind)")
            array.append(sub.bool!)
            index += 1
        }
        XCTAssertEqual(index, 5)
        XCTAssertEqual(array, [true, false, false, true, true])
    }
    
    func testArrayAllString() {
        var json:JSON = JSON(rawValue: ["aoo","bpp","zoo"])!
        XCTAssertEqual(json.count, 3)
        
        var index = 0
        var array = [String]()
        for (i, sub) in json {
            XCTAssertEqual(sub, json[index])
            let ind: Int? = index
            XCTAssertEqual(i, "\(ind)")
            array.append(sub.string!)
            index += 1
        }
        XCTAssertEqual(index, 3)
        XCTAssertEqual(array, ["aoo","bpp","zoo"])
    }
    
    func testArrayWithNull() {
        #if os(Linux)
        var json:JSON = JSON(rawValue: ["aoo","bpp", NSNull() ,"zoo"] as [Any?])!
        #else
        var json:JSON = JSON(rawValue: ["aoo","bpp", NSNull() ,"zoo"])!
        #endif
        XCTAssertEqual(json.count, 4)
        
        var index = 0

        typealias AnyType = Any //swift compiler does not like [Any]() expression
        var array = [AnyType]()
        for (i, sub) in json {
            XCTAssertEqual(sub, json[index])
            let ind: Int? = index
            XCTAssertEqual(i, "\(ind)")
            array.append(sub.object)
            index += 1
        }
        XCTAssertEqual(index, 4)
        XCTAssertEqual(array[0] as? String, "aoo")
        XCTAssertEqual(array[2] as? NSNull, NSNull())
    }
    
    func testArrayAllDictionary() {
        var json:JSON = [["1":1, "2":2], ["a":"A", "b":"B"], ["null":NSNull()]]
        XCTAssertEqual(json.count, 3)
        
        var index = 0

        typealias AnyType = Any //swift compiler does not like [Any]() expression
        var array = [AnyType]()
        for (i, sub) in json {
            XCTAssertEqual(sub, json[index])
            let ind: Int? = index
            XCTAssertEqual(i, "\(ind)")
            array.append(sub.object)
            index += 1
        }
        XCTAssertEqual(index, 3)
        #if !os(Linux)
        // Such conversions are not supported on Linux
        XCTAssertEqual((array[0] as! [String : Int])["1"]!, 1)
        XCTAssertEqual((array[0] as! [String : Int])["2"]!, 2)
        XCTAssertEqual((array[1] as! [String : String])["a"]!, "A")
        XCTAssertEqual((array[1] as! [String : String])["b"]!, "B")
        XCTAssertEqual((array[2] as! [String : NSNull])["null"]!, NSNull())
        #endif
    }
    
    func testDictionaryAllNumber() {
        var json:JSON = ["double":1.11111, "int":987654321]
        XCTAssertEqual(json.count, 2)
        
        var index = 0
        var dictionary = [String:NSNumber]()
        for (key, sub) in json {
            XCTAssertEqual(sub, json[key])
            dictionary[key] = sub.number!
            index += 1
        }
        
        XCTAssertEqual(index, 2)
        XCTAssertEqual(dictionary["double"]! as NSNumber, 1.11111)
        XCTAssertEqual(dictionary["int"]! as NSNumber, 987654321)
    }
    
    func testDictionaryAllBool() {
        var json:JSON = ["t":true, "f":false, "false":false, "tr":true, "true":true]
        XCTAssertEqual(json.count, 5)
        
        var index = 0
        var dictionary = [String:Bool]()
        for (key, sub) in json {
            XCTAssertEqual(sub, json[key])
            dictionary[key] = sub.bool!
            index += 1
        }
        
        XCTAssertEqual(index, 5)
        XCTAssertEqual(dictionary["t"]! as Bool, true)
        XCTAssertEqual(dictionary["false"]! as Bool, false)
    }
    
    func testDictionaryAllString() {
        var json:JSON = JSON(rawValue: ["a":"aoo","bb":"bpp","z":"zoo"])!
        XCTAssertEqual(json.count, 3)
        
        var index = 0
        var dictionary = [String:String]()
        for (key, sub) in json {
            XCTAssertEqual(sub, json[key])
            dictionary[key] = sub.string!
            index += 1
        }
        
        XCTAssertEqual(index, 3)
        XCTAssertEqual(dictionary["a"]! as String, "aoo")
        XCTAssertEqual(dictionary["bb"]! as String, "bpp")
    }
    
    func testDictionaryWithNull() {
        #if os(Linux)
            var json:JSON = JSON(rawValue: ["a":"aoo","bb":"bpp","null":NSNull(), "z":"zoo"] as [String:Any?])!
        #else
            var json:JSON = JSON(rawValue: ["a":"aoo","bb":"bpp","null":NSNull(), "z":"zoo"])!
        #endif
        XCTAssertEqual(json.count, 4)
        
        var index = 0

        typealias AnyType = Any //swift compiler does not like [Any]() expression
        var dictionary = [String: AnyType]()
        for (key, sub) in json {
            XCTAssertEqual(sub, json[key])
            dictionary[key] = sub.object
            index += 1
        }
        
        XCTAssertEqual(index, 4)
        XCTAssertEqual(dictionary["a"]! as? String, "aoo")
        XCTAssertEqual(dictionary["bb"]! as? String, "bpp")
        XCTAssertEqual(dictionary["null"]! as? NSNull, NSNull())
    }
    
    func testDictionaryAllArray() {
        var json:JSON = JSON (["Number":[NSNumber(value:1),NSNumber(value:2.123456),NSNumber(value:123456789)], "String":["aa","bbb","cccc"], "Mix":[true, "766", NSNull(), 655231.9823]])

        XCTAssertEqual(json.count, 3)
        
        var index = 0

        typealias AnyType = Any //swift compiler does not like [Any]() expression
        var dictionary = [String: AnyType]()
        for (key, sub) in json {
            XCTAssertEqual(sub, json[key])
            dictionary[key] = sub.object
            index += 1
        }
        
        XCTAssertEqual(index, 3)
        #if !os(Linux)
        // Such conversions are not supported on Linux
        XCTAssertEqual((dictionary["Number"] as! NSArray)[0] as? Int, 1)
        XCTAssertEqual((dictionary["Number"] as! NSArray)[1] as? Double, 2.123456)
        XCTAssertEqual((dictionary["String"] as! NSArray)[0] as? String, "aa")
        XCTAssertEqual((dictionary["Mix"] as! NSArray)[0] as? Bool, true)
        XCTAssertEqual((dictionary["Mix"] as! NSArray)[1] as? String, "766")
        XCTAssertEqual((dictionary["Mix"] as! NSArray)[2] as? NSNull, NSNull())
        XCTAssertEqual((dictionary["Mix"] as! NSArray)[3] as? Double, 655231.9823)
        #endif
    }
}
