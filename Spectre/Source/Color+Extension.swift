import SwiftUI

extension Color {
    init(r: Double, g: Double, b: Double) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0)
    }

    static var background: Color { .init(r: 34, g: 34, b: 34)}
    static var navBar: Color { .init(r: 45, g: 44, b: 48) }
    static var darkElfGray: Color { .init(r: 61, g: 62, b: 68) }
    static var bluePurple: Color { .init(r: 78, g: 68, b: 206) }
    static var darkOnyxGray: Color { .init(r: 45, g: 44, b: 48) }
    static var blackTieGray: Color { .init(r: 71, g: 71, b: 71) }
}
