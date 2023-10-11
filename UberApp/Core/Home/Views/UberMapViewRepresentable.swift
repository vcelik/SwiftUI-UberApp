//
//  UberMapViewRepresentable.swift
//  UberApp
//
//  Created by Volkan Celik on 08/08/2023.
//

import SwiftUI
import MapKit

struct UberMapViewRepresentable:UIViewRepresentable{
    
    let mapView=MKMapView()
   // let locationManager=LocationManager.shared
    @Binding var mapState:MapViewState
    //@EnvironmentObject var locationViewModel:LocationSearchViewModel
    @EnvironmentObject var homeViewModel:HomeViewModel
    
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate=context.coordinator
        mapView.isRotateEnabled=false
        mapView.showsUserLocation=true
        mapView.userTrackingMode = .follow
        
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        print("Map state is \(mapState)")
        switch mapState {
        case .noInput:
            context.coordinator.clearMapViewAndRecenterOnUserLocation()
            context.coordinator.addDriversToMap(homeViewModel.drivers)
            break
        case .searchingForLocation:
            break
        case .locationSelected:
            if let coordinate=homeViewModel.selectedUberLocation?.coordinate{
                print("Adding stuff to map...")
                context.coordinator.addAndSelectAnnotation(withCoordinate: coordinate)
                context.coordinator.configurePolyline(withDestinationCoordinate: coordinate)
            }
            break
        case .polylineAdded:
            break
        default:
            break
        }
    }
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
    
}

extension UberMapViewRepresentable{
    
    class MapCoordinator:NSObject,MKMapViewDelegate{
        
        // MARK: - Proporties
        
        let parent:UberMapViewRepresentable
        var userLocationCoordinate:CLLocationCoordinate2D?
        var currentRegion:MKCoordinateRegion?
        
        // MARK: - Lifecycle
        
        init(parent: UberMapViewRepresentable) {
            self.parent = parent
            super.init()
        }
        
        // MARK: - MKMapViewDelegate
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            self.userLocationCoordinate=userLocation.coordinate
            let region=MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            self.currentRegion=region
            
            parent.mapView.setRegion(region, animated: true)
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let polyline=MKPolylineRenderer(overlay: overlay)
            polyline.strokeColor = .systemBlue
            polyline.lineWidth=6
            return polyline
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if let annotation=annotation as? DriverAnnotation{
                let view=MKAnnotationView(annotation: annotation, reuseIdentifier: "driver")
                view.image=UIImage(named: "chevron-sign-to-right")
                return view
            }
            return nil
        }
        
        // MARK: - Helpers
        
        func addAndSelectAnnotation(withCoordinate coordinate:CLLocationCoordinate2D){
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            let anno=MKPointAnnotation()
            anno.coordinate=coordinate
            parent.mapView.addAnnotation(anno)
            parent.mapView.selectAnnotation(anno, animated: true)
            
          //  parent.mapView.showAnnotations(parent.mapView.annotations, animated: true)
        }
        
        func configurePolyline(withDestinationCoordinate coordinate:CLLocationCoordinate2D){
            guard let userLocationCoordinate=self.userLocationCoordinate else {return}
                parent.homeViewModel.getDestinationRoute(from: userLocationCoordinate, to: coordinate) { route in
                self.parent.mapView.addOverlay(route.polyline)
                self.parent.mapState = .polylineAdded // is added not to repeat the updateUIView
                let rect=self.parent.mapView.mapRectThatFits(route.polyline.boundingMapRect,edgePadding: .init(top: 64, left: 32, bottom: 500, right: 32))
                
                self.parent.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
            }
        }
        
        
        func clearMapViewAndRecenterOnUserLocation(){
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            parent.mapView.removeOverlays(parent.mapView.overlays)
            
            if let currentRegion=currentRegion{
                parent.mapView.setRegion(currentRegion, animated: true)
            }
        }
        
        func addDriversToMap(_ drivers:[User]){
            let annotations=drivers.map({DriverAnnotation(driver: $0)})
            self.parent.mapView.addAnnotations(annotations)

            //for driver in drivers{
                //let coordinate=CLLocationCoordinate2D(latitude: driver.coordinates.latitude, longitude: driver.coordinates.longitude)
                //let anno=MKPointAnnotation()
                //anno.coordinate=coordinate
                //parent.mapView.addAnnotation(anno)
                
                
            //}
        }
    }
}