import Foundation
import CoreLocation

// Classe que gerencia a localização do user
class ManageLocalizacao: NSObject, ObservableObject, CLLocationManagerDelegate {
    // CLLocationManaher lida com a localização
    private let manager = CLLocationManager()
    // Variáveis para guardar a localização e o status da permissão de localização
    @Published var location: CLLocationCoordinate2D?
    @Published var locationPermissionGranted = false

    override init() {
        super.init()
        manager.delegate = self
    }
    // Solicita permissão para a localização
    func requestLocationPermission() {
        manager.requestWhenInUseAuthorization()
    }
    // Solicita a localização atual ao user
    func requestLocation() {
        manager.requestLocation()
    }
    // Delegate method chamado quando há uma mudança no status de autorização de localização
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            // Define a permissão da localização como aceite
            locationPermissionGranted = true
            // Solicita a localização após a permissão ser aceite
            requestLocation()
        } else {
            // Define a permissão da localização como negada
            locationPermissionGranted = false
        }
    }
    // Delegate method chamado quando há uma atualização na localização
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first?.coordinate {
            // Atualiza a localização para a última coordenada obtida
            self.location = location
        }
    }
    // Delegate method chamado quando ocorre um erro ao obter a localização
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Mostra o erro obtido
        print("Location manager failed with error: \(error.localizedDescription)")
    }
}
