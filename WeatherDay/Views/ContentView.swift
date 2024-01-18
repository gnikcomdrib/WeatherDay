import SwiftUI

// Tela principal para gerenciar a exibição das diversas telas com base no estado do user e permissões de localização
struct ContentView: View {
    // Armazenamento local para o ID do user após o login bem sucedido
    @AppStorage("uid") var userID: String = ""
    // Ojeto que gerencia a localização do user
    @StateObject var locationManager = ManageLocalizacao()
    // Variável que guarda o clima atual
    @State private var currentWeather: ResponseBody?

    var body: some View {
        Group {
            // Verifica se for efetuado login
            if userID.isEmpty {
            // Mostra a tela de autenticação se o user não tiver efetuado autenticação
                AuthView()
            } else {
                // Verifica as permissões de localização
                if locationManager.locationPermissionGranted {
                    if let location = locationManager.location {
                        // Se as permissões de localização foram concedidas e a localização está disponível, mostra as informações meteorológicas
                        TempoView(weather: currentWeather ?? previewTempo)
                            .onAppear {
                                // Obtém as condições climáticas atuais ao carregar a tela
                                Task {
                                    do {
                                        currentWeather = try await ManageTempo().getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                                    } catch {
                                        print("Error fetching weather: \(error)")
                                    }
                                }
                            }
                    } else {
                        // Se a localização ainda não está disponível, exibe a tela de carregamento enquanto solicita a localização
                        LoadingView()
                            .onAppear {
                                locationManager.requestLocation()
                            }
                    }
                } else {
                    // Se as permissões de localização não foram concedidas, mostra a tela para conceder permissão
                    LocationPermissionView(permissionGranted: $locationManager.locationPermissionGranted)
                        .onAppear {
                            locationManager.requestLocationPermission()
                        }
                }
            }
        }
    }
}

// Tela que solicita permissão para a localização
struct LocationPermissionView: View {
    @Binding var permissionGranted: Bool

    var body: some View {
        VStack {
            Color.black.edgesIgnoringSafeArea(.all)
            // Botão para solicitar acesso
            Button("Permitir Acesso") {
                permissionGranted = true
            }
        }
    }
}
