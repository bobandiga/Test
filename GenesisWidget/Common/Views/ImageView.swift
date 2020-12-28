//
//  ImageView.swift
//  GenesisWidget
//
//  Created by Максим Шаптала on 27.12.2020.
//

import SwiftUI

typealias Action = () -> Void

struct ImageView: View {
    var image: UIImage?
    var body: some View {
        if let image = self.image {
            GeometryReader(content: { geometry in
                Image(uiImage: image)
                    .resizable()
                    .cornerRadius(min(geometry.size.width, geometry.size.height) / 20)
                    .clipped()
            })
            
        } else {
            GeometryReader(content: { geometry in
                Rectangle()
                    .fill(Color.lightGray())
                    .cornerRadius(min(geometry.size.width, geometry.size.height) / 20)
            })
            
        }
    }
}

enum DeletedImageState {
    case image(image: UIImage)
    case delete(image: UIImage)
}
struct DeletetedImageView: View {
    
    @State var state: DeletedImageState
    var deleteAction: Action
    
    var body: some View {
        switch state {
        case .delete(let image):
            ZStack {
                ImageView(image: image)
                    .cornerRadius(16)
                    .clipped()
                    .onTapGesture(count: 1, perform: {
                        state = .image(image: image)
                    })
                VStack {
                    HStack {
                        Spacer()
                        ButtonFactory.fillCloseButton(action: deleteAction)
                    }
                    Spacer()
                }
            }.frame(width: 64.0, height: 64.0)
        case .image(let image):
            ImageView(image: image)
                .frame(width: 64.0, height: 64.0)
                .cornerRadius(16)
                .clipped()
                .onTapGesture(count: 1, perform: {
                    state = .delete(image: image)
                })
        }
    }
}

