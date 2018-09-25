import Core
import SourceKittenFramework

protocol ElementParser {
    associatedtype T: Element
    static func parse(structure: [String: SourceKitRepresentable], key: SwiftDocKey, raw: File) -> [T]
    static func parse(structure: [String: SourceKitRepresentable], raw: File) -> T?
}

extension ElementParser {
    static func parse(structure: [String: SourceKitRepresentable], key: SwiftDocKey, raw: File) -> [T] {
        guard let substructures = structure[key.rawValue] as? [SourceKitRepresentable] else {
            return []
        }

        return substructures
            .compactMap { $0 as? [String: SourceKitRepresentable] }
            .map { parse(structure: $0, raw: raw) }
            .compactMap { $0 }
    }
}
