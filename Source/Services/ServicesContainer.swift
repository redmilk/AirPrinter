//
//  ServicesContainer.swift
//  AirPrint
//
//  Created by Danyl Timofeyev on 27.11.2021.
//

import Foundation

fileprivate let services = ServicesContainer()

final class ServicesContainer {
    lazy var pdfService: PDFService = PDFServiceImpl()
}

// MARK: - add specific service dependency to object

/// PDF Service
protocol PdfServiceProvidable { }
extension PdfServiceProvidable {
    var pdfService: PDFService { services.pdfService }
}

// MARK: - if you want to include all services to object

/// All services
protocol AllServicesProvidable { }
extension AllServicesProvidable {
    var allServices: ServicesContainer { services }
}
