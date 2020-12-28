//
//  LargeCollageView.swift
//  GenesisWidget
//
//  Created by Максим Шаптала on 28.12.2020.
//

import SwiftUI

struct LargeCollageView: View {
    var selectedLayoutIndex: Int
    var collage: Collage
    
    var isSelected = false
    
    private var bgColor: Color {
        isSelected ? Color.borderGray() : Color.darkGray()
    }
    private var tintColor: Color {
        isSelected ? Color.selectedGray() : Color.lightGray()
    }
    
    var body: some View {
        GeometryReader(content: { geometry in
            ZStack {
                bgColor
                content.padding(10).foregroundColor(tintColor)
            }
                .cornerRadius(min(geometry.size.width, geometry.size.height) / 20)
        })
    }
    
    var content: some View {
        switch selectedLayoutIndex {
        case 0:
            return AnyView(VStack {
                ImageView(image: collage.images[0] ?? nil)
                HStack {
                    ImageView(image: collage.images[2] ?? nil)
                    ImageView(image: collage.images[1] ?? nil)
                }
            })
        case 1:
            return AnyView(VStack {
                HStack {
                    ImageView(image: collage.images[0] ?? nil)
                    ImageView(image: collage.images[1] ?? nil)
                }
                HStack {
                    ImageView(image: collage.images[3] ?? nil)
                    ImageView(image: collage.images[2] ?? nil)
                }
            })
            
        case 2:
            return AnyView(VStack {
                HStack {
                    ImageView(image: collage.images[0] ?? nil)
                    ImageView(image: collage.images[1] ?? nil)
                }
                ImageView(image: collage.images[2] ?? nil)
            })
        case 3:
            return AnyView(HStack {
                ImageView(image: collage.images[0] ?? nil)
                VStack {
                    ImageView(image: collage.images[2] ?? nil)
                    ImageView(image: collage.images[1] ?? nil)
                }
            })
        default: fatalError()
        }
    }
}
