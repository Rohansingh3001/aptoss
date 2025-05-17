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
```

---

## ❗ Error Codes

| Code | Constant                     | Meaning                                      |
|------|------------------------------|----------------------------------------------|
| 1    | `ETEMPERATURE_OUT_OF_RANGE`  | Recorded temperature is outside valid range |
| 2    | `EDRUG_NOT_REGISTERED`       | Drug is not registered in the system         |

---

## 🔧 Public Entry Functions

### `register_drug`

Registers a new drug under the manufacturer's signer account.

```move
public entry fun register_drug(
    manufacturer: &signer,
    id: String,
    name: String,
    min_temp: u64,
    max_temp: u64
)
```

- `min_temp` and `max_temp` are in Celsius × 100 (e.g., 2500 = 25.00°C).

---

### `record_temperature`

Records a temperature reading for a registered drug and checks its validity.

```move
public entry fun record_temperature(
    recorder: &signer,
    manufacturer: address,
    drug_id: String,
    temperature: u64
) acquires Drug
```

- Marks the drug as invalid if the temperature is out of range.

---

## 🧪 Example Usage

```move
// Registering a drug
register_drug(&manufacturer, "D123", "VaccineX", 2000, 2500);

// Recording temperature
record_temperature(&agent, manufacturer_address, "D123", 2300);
```

---

## 📄 Deployment Info

- **Module Name:** `DrugRegistry`
- **Contract Address:** `0xc988f308d95d60be8db1b44c820475cff893808611a201a40c12a1a3b1445fd2`

---

## 📸 Deployment Proof

![Transaction Screenshot](./f45b0caa-3e00-40ce-8f06-8526ff10e5ad.png)

_This image shows the successful transaction confirming deployment on Aptos Devnet._

---

## 📜 License

MIT
