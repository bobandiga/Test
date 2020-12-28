//
//  ButtonFactory.swift
//  GenesisWidget
//
//  Created by Максим Шаптала on 27.12.2020.
//

import Foundation
import SwiftUI

struct ButtonFactory {
    static func unionButton(_ isEnabled: Bool, action: @escaping Action) -> some View {
        if !isEnabled {
            return AnyView(Image("Union")
                            .renderingMode(.template)
                            .foregroundColor(.darkGray()))
                .frame(width: 24.0, height: 24.0)
        } else {
            return AnyView(Image("Union")
                            .renderingMode(.template)
                            .foregroundColor(.white)
                            .onTapGesture(count: 1, perform: action))
                .frame(width: 24.0, height: 24.0)
        }
    }
    
    static func moreButton(action: @escaping Action) -> some View {
        return Button(action: action, label: {
            Image(systemName: "ellipsis")
        })
        .frame(width: 24.0, height: 24.0)
    }
    
    static func closeButton(action: @escaping Action) -> some View {
        return Button(action: action, label: {
            Image(systemName: "xmark")
        })
        .frame(width: 24.0, height: 24.0)
    }
    
    static func fillCloseButton(action: @escaping Action) -> some View {
        return Button(action: action, label: {
            ZStack {
                Color.white
                Color.black.frame(width: 26.0, height: 26.0).cornerRadius(13)
                Image(systemName: "xmark")
            }.cornerRadius(14)
        })
        .frame(width: 28.0, height: 28.0)
    }
    
    static func photoButton(action: @escaping Action) -> some View {
        return Button(action: action, label: {
            VStack {
                ZStack {
                    Color.lightGray()
                        .cornerRadius(16)
                        .frame(width: 64.0, height: 64.0)
                    
                    Image("photo")
                        .frame(width: 32.0, height: 32.0)
                }
                Spacer()
                Text("Photos").bold()
            }
        }).frame(width: 64.0, height: 80.0)
    }
    
    static func layoutButton(action: @escaping Action) -> some View {
        return Button(action: action, label: {
            VStack {
                ZStack {
                    Color.lightGray()
                        .frame(width: 64.0, height: 64.0)
                        .cornerRadius(16)
                    Image("layout")
                        .frame(width: 32.0, height: 32.0)
                }
                Spacer()
                Text("Layout").bold()
            }
        }).frame(width: 64.0, height: 80.0)
    }
    
    static func addPhotoButton(action: @escaping Action) -> some View {
        return Button(action: action, label: {
            ZStack {
                Color.darkGray()
                    .frame(width: 64.0, height: 64.0)
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.lightGray(), lineWidth: 1)
                    )
                Image(systemName: "plus")
                    .frame(width: 32.0, height: 32.0)
            }
        })
    }
}

