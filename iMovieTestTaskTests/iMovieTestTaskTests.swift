//
//  iMovieTestTaskTests.swift
//  iMovieTestTaskTests
//
//  Created by Владислав Мазуров on 26.02.24.
//

import XCTest
@testable import iMovieTestTask

final class iMovieTestTaskTests: XCTestCase {
    
    var listVC: ListViewController!

    override func setUpWithError() throws {
       
        listVC = ListViewController()
    }

    override func tearDownWithError() throws {

        listVC = nil
    }

    func testExample() throws {

        listVC.fetchData(page: 1)
        
        XCTAssertNoThrow(listVC.fetchData(page: 1), "Не вызывает ошибок")
        XCTAssertEqual(listVC.docs.isEmpty, true, "Массив пустой")
        XCTAssertNil(listVC.films, "Пустой обьект")
        // wtf я же по идее вызвал функцию которая этот массив заполняет, мейби чет не так делаю....
    }

    func testPerformanceExample() throws {
        
        let page = 1
        
        self.measure(
            metrics: [
                        XCTClockMetric(),
                        XCTCPUMetric(),
                        XCTStorageMetric(),
                        XCTMemoryMetric()
                    ]
        
        
        ) {
            listVC.fetchData(page: page)
            // listVC.viewDidLoad()
        }
    }

}
