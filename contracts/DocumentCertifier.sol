// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title DocumentCertifier - Certification de documents sur Ethereum
/// @notice Permet de certifier et vérifier l'authenticité de documents via leur hash
contract DocumentCertifier {

    // ─── Structures ───────────────────────────────────────────────
    struct Document {
        bytes32  hash;           // Empreinte SHA-256 du document
        address  certifier;      // Adresse qui a certifié
        uint256  timestamp;      // Date de certification
        string   description;    // Description libre (titre, auteur...)
        bool     exists;         // Sentinelle d'existence
    }

    // ─── État ─────────────────────────────────────────────────────
    address public owner;
    uint256 public documentCount;

    mapping(bytes32 => Document) private documents;   // hash → Document
    bytes32[] private allHashes;                       // historique

    // ─── Événements ───────────────────────────────────────────────
    event DocumentCertified(
        bytes32 indexed docHash,
        address indexed certifier,
        uint256 timestamp,
        string  description
    );

    // ─── Modificateurs ────────────────────────────────────────────
    modifier onlyOwner() {
        require(msg.sender == owner, "Acces refuse : pas le proprietaire");
        _;
    }

    modifier notAlreadyCertified(bytes32 _hash) {
        require(!documents[_hash].exists, "Document deja certifie");
        _;
    }

    // ─── Constructeur ─────────────────────────────────────────────
    constructor() {
        owner = msg.sender;
        documentCount = 0;
    }

    // ─── Fonctions principales ────────────────────────────────────

    /// @notice Certifie un document en stockant son hash on-chain
    /// @param _hash       Hash SHA-256 du fichier (bytes32)
    /// @param _description Titre ou description courte du document
    function certifyDocument(bytes32 _hash, string calldata _description)
        external
        notAlreadyCertified(_hash)
    {
        documents[_hash] = Document({
            hash:        _hash,
            certifier:   msg.sender,
            timestamp:   block.timestamp,
            description: _description,
            exists:      true
        });

        allHashes.push(_hash);
        documentCount++;

        emit DocumentCertified(_hash, msg.sender, block.timestamp, _description);
    }

    /// @notice Vérifie si un document est certifié et retourne ses infos
    /// @param _hash Hash du document à vérifier
    function verifyDocument(bytes32 _hash)
        external
        view
        returns (
            bool    isCertified,
            address certifier,
            uint256 timestamp,
            string  memory description
        )
    {
        Document storage doc = documents[_hash];
        if (!doc.exists) {
            return (false, address(0), 0, "");
        }
        return (true, doc.certifier, doc.timestamp, doc.description);
    }

    /// @notice Retourne tous les hashs certifiés (pour l'interface)
    function getAllHashes() external view returns (bytes32[] memory) {
        return allHashes;
    }

    /// @notice Retourne le nombre total de documents certifiés
    function getDocumentCount() external view returns (uint256) {
        return documentCount;
    }
}