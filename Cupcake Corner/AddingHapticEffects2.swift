//
//  AddingHapticEffects2.swift
//  Cupcake Corner
//
//  Created by Marko Zivanovic on 23. 7. 2025..
//

//MARK: - AddingHapticEffects2 Present Multiple Events

// MARK: - For Advanced Haptic Version Import CoreHaptic
import CoreHaptics
import SwiftUI

struct AddingHapticEffects2: View {
    
    //@State private var counter = 0
    @State private var engine: CHHapticEngine?
    
    var body: some View {
        //Button("Tap Count \(counter)") {
        Button("Play Haptic", action: complexSuccess)
            //counter += 1
            //complexSuccess()
            .onAppear(perform: prepareHaptic)
        
        // MARK: - That is easy option
        //.sensoryFeedback(.impact(weight: .heavy, intensity: 1), trigger: counter)
    }
    // MARK: - Advanced Haptic
    func prepareHaptic() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
            
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    func complexSuccess() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        var events = [CHHapticEvent]()
        
        //MARK: - This is the main change for multiple events
        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
            
            events.append(event)
        }
        
        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
            
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1 + i)
            
            events.append(event)
        }
                
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription)")
        }
    }
}

#Preview {
    AddingHapticEffects()
}


