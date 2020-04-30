import Foundation

struct results: Decodable {
    let results: [resultsData]
    let resultCount: Int
}
