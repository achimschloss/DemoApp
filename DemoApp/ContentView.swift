import SwiftUI
import NetIdMobileSdk

struct ContentView: View {

    @EnvironmentObject var serviceViewModel: ServiceViewModel

    var body: some View {
        ZStack {
            if serviceViewModel.authorizationViewVisible {
                Rectangle()
                    .foregroundColor(Color.black.opacity(0.5))
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .zIndex(2)
                    .onTapGesture {
                        NetIdService.sharedInstance.didTapDismiss()
                    }
                
                VStack {
                    Spacer()
                    serviceViewModel.getAuthorizationView()
                        .padding(.bottom, 12)
                        .cornerRadius(12)
                        .shadow(radius: 7)
                }
                .padding(.bottom, -12)
                .transition(.move(edge: .bottom))
                .ignoresSafeArea()
                .zIndex(3)
            }
            
            VStack {
                Spacer()
                Button(action: {
                    serviceViewModel.authFlow = .Permission
                    serviceViewModel.authorizeNetIdService()
                }) {
                    Text("Authorize")
                        .foregroundColor(Color.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(5)
                }
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(ServiceViewModel())
    }
}

