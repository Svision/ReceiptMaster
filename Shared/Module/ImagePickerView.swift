//
//  ImagePickerView.swift
//  ReceiptMaster
//
//  Created by Changhao Song on 2022-06-06.
//

import SwiftUI

struct ImagePickerView: View {
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    var body: some View {
        Button(action: {
            self.showingImagePicker = true
        }, label: {
            Text("Choose COSTCO RECEIPT")
        })
        .sheet(isPresented: $showingImagePicker, onDismiss: saveImage) {
            ImagePicker(image: self.$inputImage)
        }
    }
    
    private func saveImage() {
        guard let inputImage = inputImage else { return }
        
        var newReceipt = Receipt(receiptImage: inputImage)
        newReceipt.processReceipt()
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }

            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }
}
