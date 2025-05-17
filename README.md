# ColdChain::DrugRegistry

A Move module for Aptos to register and monitor cold-chain compliant drugs.  
This smart contract ensures that sensitive pharmaceuticals are stored and transported within a valid temperature range, and flags any temperature anomalies that could compromise the drug's integrity.

---

## 📦 Module Overview

The `ColdChain::DrugRegistry` module allows pharmaceutical manufacturers to:

- Register new drugs with defined acceptable temperature ranges.
- Record and validate real-time temperature data.
- Track a drug’s validity based on temperature compliance.

---

## 🧱 Structs

### `Drug`

```move
struct Drug has key, store {
    id: String,
    name: String,
    manufacturer: address,
    min_temp: u64,      // Minimum temperature in Celsius * 100
    max_temp: u64,      // Maximum temperature in Celsius * 100
    last_temp: u64,     // Last recorded temperature
    last_update: u64,   // Timestamp of last update (microseconds)
    valid: bool         // Validity flag
}
