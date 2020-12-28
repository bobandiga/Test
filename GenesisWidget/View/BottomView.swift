//
//  BottomView.swift
//  GenesisWidget
//
//  Created by Максим Шаптала on 28.12.2020.
//

import SwiftUI
import ImagePicker

enum BottomViewState {
    case `default`
    case layout
    case photos
    
    var title: String {
        switch self {
        case .layout:
            return "Layout"
        case .photos:
            return "Photos"
        default:
            return ""
        }
    }
}

struct BottomView: View {
    
    @ObservedObject var viewModel: LayoutViewModel
    @State private var state: BottomViewState = .default
    @State private var isPickerOpened = false
    @State private var selectedButtonIndex: Int = 0
    
    var body: some View {
        ZStack {
            Color.darkGray()
            VStack(alignment: .center) {
                Spacer()
                pickerView
                    .frame(height: viewModel.bottomHeight)
                Spacer()
                if (state != .default) {
                    bottomBar
                }
            }
        }
        .frame(height: (state != .default) ? viewModel.bottomHeight + 80 : viewModel.bottomHeight)
    }
    
    var pickerView: some View {
        switch state {
        case .layout:
            return AnyView(layoutPicker)
        case .photos:
            return AnyView(photoPicker)
        case .default:
            return AnyView(defaultPicker)
        }
    }
    
    var bottomBar: some View {
        ZStack(alignment: .top) {
            HStack {
                Spacer()
                ButtonFactory.closeButton {
                    state = .default
                }
            }
            Text(state.title).bold()
        }
        .padding(16)
        .border(width: 1, edges: [.top], color: Color.lightGray())
        .frame(height: 80)
    }
    
    private var defaultPicker: some View {
        HStack(spacing: 24) {
            ButtonFactory.layoutButton {
                state = .layout
            }
            ButtonFactory.photoButton {
                state = .photos
            }
        }
    }
    
    private var photoPicker: some View {
        HStack(spacing: 16) {
            ForEach(0..<viewModel.limit) { (index) -> AnyView in
                if let image = viewModel.collage.images[index] as? UIImage {
                    return AnyView(DeletetedImageView(state: .image(image: image)) {
                        viewModel.setImage(index: index, image: nil)
                    })
                } else {
                    return AnyView(ButtonFactory.addPhotoButton(action:  {
                        selectedButtonIndex = index
                        isPickerOpened = true
                    }).sheet(isPresented: $isPickerOpened, content: {
                        PImagePicker(imageCallback: loadImage(_:), imagesCallback: loadImages(_:_:), isOpened: $isPickerOpened, limit: viewModel.limit)
                    }))
                }
            }
        }
    }
    
    private var layoutPicker: some View {
        switch viewModel.widgetType {
        case .small:
            return AnyView(GeometryReader(content: { geometry in
                VStack {
                    Spacer()
                    HStack {
                        Button(action: {
                            viewModel.setCollage(index: 0)
                        }, label: {
                            CollageView(selectedLayoutIndex: 0, collage: Collage(), isSelected: viewModel.selectedLayoutIndex == 0).aspectRatio(contentMode: .fit)
                        })
                        Button(action: {
                            viewModel.setCollage(index: 1)
                        }, label: {
                            CollageView(selectedLayoutIndex: 1, collage: Collage(), isSelected: viewModel.selectedLayoutIndex == 1).aspectRatio(contentMode: .fit)
                        })
                        Button(action: {
                            viewModel.setCollage(index: 2)
                        }, label: {
                            CollageView(selectedLayoutIndex: 2, collage: Collage(), isSelected: viewModel.selectedLayoutIndex == 2).aspectRatio(contentMode: .fit)
                        })
                        Button(action: {
                            viewModel.setCollage(index: 3)
                        }, label: {
                            CollageView(selectedLayoutIndex: 3, collage: Collage(), isSelected: viewModel.selectedLayoutIndex == 3).aspectRatio(contentMode: .fit)
                        })
                    }.padding()
                    Spacer()
                }
            }))
        case .medium:
            return AnyView(GeometryReader(content: { geometry in
                        VStack {
                            HStack {
                                Button(action: {
                                    viewModel.setCollage(index: 0)
                                }, label: {
                                    MediumCollageView(selectedLayoutIndex: 0, collage: Collage(), isSelected: viewModel.selectedLayoutIndex == 0)
                                })
                                Button(action: {
                                    viewModel.setCollage(index: 1)
                                }, label: {
                                    MediumCollageView(selectedLayoutIndex: 1, collage: Collage(), isSelected: viewModel.selectedLayoutIndex == 1)
                                })
                            }
                            HStack {
                                Button(action: {
                                    viewModel.setCollage(index: 2)
                                }, label: {
                                    MediumCollageView(selectedLayoutIndex: 2, collage: Collage(), isSelected: viewModel.selectedLayoutIndex == 2)
                                })
                                Button(action: {
                                    viewModel.setCollage(index: 3)
                                }, label: {
                                    MediumCollageView(selectedLayoutIndex: 3, collage: Collage(), isSelected: viewModel.selectedLayoutIndex == 3)
                                })
                            }
                        }}))
        case .large:
            return AnyView(GeometryReader(content: { geometry in
                VStack {
                    Spacer()
                    HStack {
                        Button(action: {
                            viewModel.setCollage(index: 0)
                        }, label: {
                            LargeCollageView(selectedLayoutIndex: 0, collage: Collage(), isSelected: viewModel.selectedLayoutIndex == 0).aspectRatio(contentMode: .fit)
                        })
                        Button(action: {
                            viewModel.setCollage(index: 1)
                        }, label: {
                            LargeCollageView(selectedLayoutIndex: 1, collage: Collage(), isSelected: viewModel.selectedLayoutIndex == 1).aspectRatio(contentMode: .fit)
                        })
                        Button(action: {
                            viewModel.setCollage(index: 2)
                        }, label: {
                            LargeCollageView(selectedLayoutIndex: 2, collage: Collage(), isSelected: viewModel.selectedLayoutIndex == 2).aspectRatio(contentMode: .fit)
                        })
                        Button(action: {
                            viewModel.setCollage(index: 3)
                        }, label: {
                            LargeCollageView(selectedLayoutIndex: 3, collage: Collage(), isSelected: viewModel.selectedLayoutIndex == 3).aspectRatio(contentMode: .fit)
                        })
                    }.padding()
                    Spacer()
                }
            }))
        }
    }
    
    private func loadImage(_ image: UIImage) {
        viewModel.setImage(index: selectedButtonIndex, image: image)
    }
    
    private func loadImages(_ index: Int, _ image: UIImage) {
        var i = index + selectedButtonIndex
        i = i >= viewModel.limit ? i - viewModel.limit : i
        viewModel.setImage(index: i, image: image)
    }
}

