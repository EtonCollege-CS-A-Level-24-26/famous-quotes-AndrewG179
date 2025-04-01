//
//  QuoteRepository.swift
//  FamousQuotesParse
//
//  Created by Cormell, David - DPC on 18/03/2025.
//

import Foundation
import ParseSwift


class QuoteRepository {
    static let shared = QuoteRepository()
    
    private init() {}
    
    func saveQuote(quote: Quote) {
        let quoteDao = QuoteDao(author: quote.author, content: quote.content)
        do {
            try quoteDao.save()
        } catch {
            print("Failing to save quote: \(quote.content)")
        }
    }
    
    func getAllQuotes(completion: @escaping ([Quote]) -> Void) {
        let query = QuoteDao.query().order([.descending("createdAt")])
        query.find() { response in
            let quotes: [Quote] = (try? response.get())?.compactMap({
                guard let author = $0.author, let content = $0.content else { return nil }
                return Quote(author: author, content: content)
            }) ?? []
            
            completion(quotes)
            
        }
    }
    
    func deleteQuote(quote: Quote) {
        let query = QuoteDao.query("author" == quote.author, "content" == quote.content)
        
        query.find { response in
            switch response {
            case .success(let quoteToDelete):
                quoteToDelete[0].delete { deleteResult in
                    switch deleteResult {
                    case .success:
                        print("Object deleted")
                    case .failure(let error):
                        print("Error deleting object: \(error.localizedDescription)")
                    }
                }
            case .failure(let error):
                print("Error retrieving object: \(error.localizedDescription)")
            }
        }
    }
}
