module ColdChain::DrugRegistry {
    use std::string::String;
    use aptos_framework::timestamp;
    use aptos_framework::signer;
    
    /// Error codes
    const ETEMPERATURE_OUT_OF_RANGE: u64 = 1;
    const EDRUG_NOT_REGISTERED: u64 = 2;
    
    /// Represents a drug in the cold chain registry
    struct Drug has key, store {
        id: String,
        name: String,
        manufacturer: address,
        min_temp: u64,      // Minimum temperature in Celsius * 100
        max_temp: u64,      // Maximum temperature in Celsius * 100
        last_temp: u64,     // Last recorded temperature
        last_update: u64,   // Timestamp of last update
        valid: bool         // Whether the drug is still valid
    }
    
    /// Register a new drug in the cold chain registry
    public entry fun register_drug(
        manufacturer: &signer,
        id: String,
        name: String,
        min_temp: u64,
        max_temp: u64
    ) {
        let manufacturer_addr = signer::address_of(manufacturer);
        
        // Create the drug record
        let drug = Drug {
            id,
            name,
            manufacturer: manufacturer_addr,
            min_temp,
            max_temp,
            last_temp: 0,
            last_update: timestamp::now_microseconds(),
            valid: true
        };
        
        // Move the drug resource to the manufacturer's account
        move_to(manufacturer, drug);
    }
    
    /// Record temperature data for a drug and validate it
    public entry fun record_temperature(
        recorder: &signer,
        manufacturer: address,
        drug_id: String, 
        temperature: u64
    ) acquires Drug {
        // Verify the drug exists
        assert!(exists<Drug>(manufacturer), EDRUG_NOT_REGISTERED);
        
        // Get the drug record
        let drug = borrow_global_mut<Drug>(manufacturer);
        
        // Update the temperature and timestamp
        drug.last_temp = temperature;
        drug.last_update = timestamp::now_microseconds();
        
        // Validate temperature range
        if (temperature < drug.min_temp || temperature > drug.max_temp) {
            // If temperature is out of range, mark drug as invalid
            drug.valid = false;
        }
    }
}
