//
//  PrintingOptionsManager.swift
//  AirPrint
//
//  Created by Danyl Timofeyev on 04.12.2021.
//

import Foundation

final class PrintingOptionsManager: NSObject {
    
    private let finishCallback: VoidClosure
    
    init(finishCallback: @escaping VoidClosure) {
        self.finishCallback = finishCallback
        super.init()
    }
    deinit {
        Logger.log(String(describing: self), type: .deinited)
    }
    
    func printUserSessionDataToLocalPrinter(pdfData: Data, jobName: String) {
         let printInfo = UIPrintInfo(dictionary: nil)
         printInfo.jobName = jobName
         printInfo.outputType = .general
         let printController = UIPrintInteractionController.shared
         printController.delegate = self
         printController.printInfo = printInfo
         printController.showsNumberOfCopies = true
         printController.printingItem = pdfData
         printController.showsPaperSelectionForLoadedPapers = true
         printController.present(animated: true, completionHandler: nil)
     }
}

extension PrintingOptionsManager: UIPrintInteractionControllerDelegate {
    func printInteractionControllerDidDismissPrinterOptions(_ printInteractionController: UIPrintInteractionController) {
        finishCallback()
    }
    func printInteractionControllerWillStartJob(_ printInteractionController: UIPrintInteractionController) {
        finishCallback()
    }
}