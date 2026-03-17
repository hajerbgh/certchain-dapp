# 🔐 CertChain — Certification de Documents sur Ethereum

> Application décentralisée (DApp) de certification et vérification de documents via la blockchain Ethereum.

![Solidity](https://img.shields.io/badge/Solidity-0.8.0-purple)
![Network](https://img.shields.io/badge/Network-Sepolia_Testnet-teal)
![Status](https://img.shields.io/badge/Status-Deployed-green)

---

## 📋 Description

CertChain permet de **certifier l'authenticité de n'importe quel document** en stockant son empreinte cryptographique (hash SHA-256) sur la blockchain Ethereum. La certification est :

- **Immuable** — impossible à modifier ou supprimer après enregistrement
- **Transparente** — vérifiable par n'importe qui, à tout moment
- **Décentralisée** — aucun serveur central, aucun intermédiaire
- **Confidentielle** — seul le hash est stocké, jamais le fichier original

---

## 🏗️ Architecture

```
certchain-dapp/
├── contracts/
│   └── DocumentCertifier.sol     # Smart contract Solidity
├── frontend/
│   └── index.html                # Interface web (HTML + ethers.js)
├── screenshots/                  # Captures pour documentation
└── README.md
```

---

## ⚙️ Prérequis

- Navigateur moderne (Chrome / Firefox)
- Extension [MetaMask](https://metamask.io) installée
- ETH de test Sepolia ([Google Cloud Faucet](https://cloud.google.com/application/web3/faucet/ethereum/sepolia))

---

## 🚀 Installation et déploiement

### 1. Cloner le dépôt

```bash
git clone https://github.com/ton-user/certchain-dapp.git
cd certchain-dapp
```

### 2. Déployer le smart contract

1. Ouvre [Remix IDE](https://remix.ethereum.org)
2. Importe `contracts/DocumentCertifier.sol`
3. Compile avec Solidity `^0.8.0`
4. Dans **Deploy & Run** → Environment : `Injected Provider - MetaMask`
5. Sélectionne le réseau **Sepolia** dans MetaMask
6. Clique **Deploy** → confirme dans MetaMask
7. **Copie l'adresse du contrat déployé**

### 3. Configurer l'interface

Dans `frontend/index.html`, remplace :

```javascript
const CONTRACT_ADDRESS = "0xTON_ADRESSE_ICI";
```

par l'adresse copiée à l'étape précédente.

### 4. Lancer l'interface

Ouvre simplement `frontend/index.html` dans ton navigateur.

---

## 📖 Utilisation

### Certifier un document

1. Clique **Connecter MetaMask**
2. Glisse-dépose ton fichier (PDF, DOCX, image...)
3. Le hash SHA-256 est calculé automatiquement dans le navigateur
4. Entre une description (titre du document)
5. Clique **Certifier sur la blockchain**
6. Confirme la transaction dans MetaMask

### Vérifier un document

1. Dans la section "Vérifier", sélectionne le fichier original
2. Clique **Vérifier l'authenticité**
3. Résultat :
   - ✅ **Certifié** → affiche le certifier, la date, la description
   - ❌ **Non certifié** → document jamais enregistré

---

## 📄 Smart Contract

**Adresse déployée (Sepolia) :** `0xd9145CCE52D386f254917e481eB44e9943F39138`

### Fonctions principales

| Fonction | Type | Description |
|----------|------|-------------|
| `certifyDocument(bytes32, string)` | `external` | Certifie un document on-chain |
| `verifyDocument(bytes32)` | `external view` | Vérifie un document |
| `getAllHashes()` | `external view` | Liste tous les hashs certifiés |
| `getDocumentCount()` | `external view` | Nombre total de certifications |

### Événement

```solidity
event DocumentCertified(
    bytes32 indexed docHash,
    address indexed certifier,
    uint256 timestamp,
    string  description
);
```

---

## 🧪 Tests effectués

| Test | Résultat |
|------|----------|
| Déploiement Sepolia | ✅ |
| Certification via Remix | ✅ |
| Vérification (hash correct) | ✅ isCertified: true |
| Doublon (même hash) | ✅ Revert attendu |
| Hash inconnu | ✅ isCertified: false |
| Interface web + MetaMask | ✅ |

---

## 🛠️ Technologies utilisées

- **Solidity ^0.8.0** — Smart contract
- **Ethereum Sepolia** — Réseau de test
- **Remix IDE** — Développement et déploiement
- **ethers.js v6** — Interaction blockchain côté client
- **MetaMask** — Portefeuille et signature des transactions
- **SubtleCrypto API** — Calcul SHA-256 local

---

## 👥 Auteurs

- [Prénom NOM 1] — [email]
- [Prénom NOM 2] — [email]

Projet universitaire — Module Blockchain — 2026
