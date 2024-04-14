//
//  YummyTheme.swift
//  YummyDate
//
//  Created by Sam Roman on 4/13/24.
//

import SwiftUI

public struct YummyTheme: Equatable {
    var primaryColor: Color
    var secondaryColor: Color
    var tertiaryColor: Color
    var primaryTextColor: Color
    var secondaryTextColor: Color
    var primaryFont: Font
    var secondaryFont: Font
    var barAlignment: Alignment
    var animation: Animation
    var scrollBehavior: ScrollBehavior

    enum ScrollBehavior {
        case staticScroll
        case infiniteScroll
    }


    public static let limeTheme = YummyTheme(
        primaryColor: Color(red: 0.75, green: 0.88, blue: 0.06),
        secondaryColor: Color(red: 1.0, green: 1.0, blue: 1.0),
        tertiaryColor: Color(red: 0.55, green: 0.55, blue: 0.55),
        primaryTextColor: Color.black,
        secondaryTextColor: Color.white,
        primaryFont: .title,
        secondaryFont: .body,
        barAlignment: .leading,
        animation: .spring,
        scrollBehavior: .infiniteScroll
    )

    public static let sunsetTheme = YummyTheme(
        primaryColor: Color(red: 0.99, green: 0.37, blue: 0.33),
        secondaryColor: Color(red: 0.93, green: 0.11, blue: 0.14),
        tertiaryColor: Color(red: 0.29, green: 0.08, blue: 0.55),
        primaryTextColor: Color.white,
        secondaryTextColor: Color.black,
        primaryFont: .headline,
        secondaryFont: .callout,
        barAlignment: .trailing,
        animation: .default,
        scrollBehavior: .staticScroll
    )

    public static let oceanTheme = YummyTheme(
        primaryColor: Color(red: 0.00, green: 0.53, blue: 0.82),
        secondaryColor: Color(red: 0.67, green: 0.84, blue: 0.90),
        tertiaryColor: Color(red: 0.20, green: 0.60, blue: 0.86),
        primaryTextColor: Color.white,
        secondaryTextColor: Color.white,
        primaryFont: .title2,
        secondaryFont: .title3,
        barAlignment: .center,
        animation: .bouncy, 
        scrollBehavior: .infiniteScroll
    )

    init(primaryColor: Color, secondaryColor: Color, tertiaryColor: Color, primaryTextColor: Color, secondaryTextColor: Color, primaryFont: Font, secondaryFont: Font, barAlignment: Alignment, animation: Animation, scrollBehavior: ScrollBehavior) {
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
        self.tertiaryColor = tertiaryColor
        self.primaryTextColor = primaryTextColor
        self.secondaryTextColor = secondaryTextColor
        self.primaryFont = primaryFont
        self.secondaryFont = secondaryFont
        self.barAlignment = barAlignment
        self.animation = animation
        self.scrollBehavior = scrollBehavior
    }
}

