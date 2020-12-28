//
//  ContentView.swift
//  GenesisWidget
//
//  Created by Максим Шаптала on 27.12.2020.
//

import SwiftUI
import ImagePicker
import SlideCard

struct BaseView: View {
    
    @StateObject var viewModel: LayoutViewModel = LayoutViewModel()
    @State var isOpenedMenu = false
    @State var isOpenedSheet = false
    
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            VStack {
                ZStack{
                    HStack{
                        ButtonFactory.closeButton {
                            viewModel.clear()
                        }
                        Spacer().layoutPriority(1)
                        ButtonFactory.moreButton {
                            isOpenedSheet = true
                        }.actionSheet(isPresented: $isOpenedSheet, content: {
                            ActionSheet(title: Text("Settings"), message: Text("Choose widget size"), buttons: [
                                .cancel(),
                                .default(Text("Default"), action: { viewModel.setWidgetType(type: .small) }),
                                .default(Text("Medium"), action: {
                                    viewModel.setWidgetType(type: .medium)
                                }),
                                .default(Text("Large"), action: {
                                    viewModel.setWidgetType(type: .large)
                                }),
                            ])
                        })
                        Spacer(minLength: 16).layoutPriority(0)
                        ButtonFactory.unionButton(!viewModel.collage.images.isEmpty) {
                            viewModel.saveWidgetCustomization()
                        }
                    }
                    Text("Widget")
                        .font(.title2)
                }
                .padding()
                collageView
                    .aspectRatio(contentMode: .fit)
                Spacer()
            }
            VStack {
                Spacer()
                BottomView(viewModel: viewModel)
            }.ignoresSafeArea()
        }
        .foregroundColor(.white)
    }
    
    private var collageView: some View {
        GeometryReader(content: { geometry in
            ZStack {
                switch viewModel.widgetType {
                case .small:
                    CollageView(selectedLayoutIndex: viewModel.selectedLayoutIndex, collage: viewModel.collage).frame(width: geometry.size.width / 2, height: geometry.size.width / 2, alignment: .center)
                case .medium:
                    MediumCollageView(selectedLayoutIndex: viewModel.selectedLayoutIndex, collage: viewModel.collage).frame(width: geometry.size.width, height: geometry.size.width / 2, alignment: .center)
                case .large:
                    LargeCollageView(selectedLayoutIndex: viewModel.selectedLayoutIndex, collage: viewModel.collage).frame(width: geometry.size.width, height: geometry.size.width, alignment: .center)
                }
                
            }.frame(width: geometry.size.width, height: geometry.size.width, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }).padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}
