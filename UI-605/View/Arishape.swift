//
//  Arishape.swift
//  UI-605
//
//  Created by nyannyan0328 on 2022/07/05.
//

import SwiftUI

struct Arishape: Shape {
    func path(in rect: CGRect) -> Path {
        
        return Path{path in
            
            let midWidth = rect.width / 2
            
            let widht = rect.width
            
            path.move(to: .zero)
            
            path.addCurve(to: CGPoint(x: widht, y: 0), control1: CGPoint(x: midWidth, y: -80), control2: CGPoint(x: midWidth, y: -80))
            
            
        }
    }
}

struct Arishape_Previews: PreviewProvider {
    static var previews: some View {
        Arishape()
    }
}
