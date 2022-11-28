import Foundation

struct Section: Hashable {
    
    let id = UUID()
    
    let type: SectionType
    let title: String
    let subtitle: String
    let items: [Item]
    
    init(type: SectionType, title: String = "", subtitle: String = "", items: [Item] = []) {
        self.type  = type
        self.title = title
        self.subtitle = subtitle
        self.items = items
    }
    
    enum ItemSectionType: String {
        case featured
        case recommended
        case latest
        case categories
    }
    
    struct SectionType: RawRepresentable, Hashable {
        typealias RawValue = String
        var rawValue: String
        
        init(rawValue: String) {
            self.rawValue = rawValue
        }
        
        static let featured = SectionType(rawValue: Section.ItemSectionType.featured.rawValue)
        static let recommended = SectionType(rawValue: Section.ItemSectionType.recommended.rawValue)
        static let latest = SectionType(rawValue: Section.ItemSectionType.latest.rawValue)
        static let categories = SectionType(rawValue: Section.ItemSectionType.categories.rawValue)
    }
}
