pragma solidity ^0.5.16;
pragma experimental ABIEncoderV2;

contract CertificateLedger {
    uint256 certCount = 0;
    struct Certificate {
        string recipientID;
        // uint256 RecipientHealth;
        string donorID;
        Health recipientHealth;
        Health donorHealth;
        address signature;
        // uint256 Contact;
        // uint256 TimeStamp;
        // bool ValidPair;
    }

    struct Health {
        uint256 age;
        uint256 PRA;
        string bloodType;
        string HLAA1;
        string HLAA2;
        string HLAB1;
        string HLAB2;
        string HLADR1;
        string HLADR2;
        string HLADQ1;
        string HLADQ2;
    }

    mapping(uint256 => Certificate) public certificates;

    constructor() public {}

    function getAddress(uint256 id) public view returns (uint256) {
        return (10);
    }

    function getRecipientHealth(uint256 id) public view returns (uint256) {
        return (certificates[id].recipientHealth.age);
    }

    function createCert(
        string memory _recipientID,
        string memory _donorID,
        Health memory _recipientHealth,
        Health memory _donorHealth,
        address _signature
    ) public {
        certificates[certCount] = Certificate(
            _recipientID,
            _donorID,
            _recipientHealth,
            _donorHealth,
            _signature
        );
        certCount++;
    }

    function getAll() public view returns (uint256) {
        return certCount;
    }

    function findMatch(address signature) public view returns (string memory) {
        uint256 index = 0;
        for (uint256 i = 0; i < certCount; i++) {
            if (signature == certificates[i].signature) {
                index = i;
            }
        }

        for (uint256 i = 0; i < certCount; i++) {
            if (index != i) {
                bool bloodTypeMatch1;
                bool PRAmatch1;
                bool ageMatch1;
                uint256 HLAmatches1;
                bool recipientMatch;

                bool bloodTypeMatch2;
                bool PRAmatch2;
                bool ageMatch2;
                uint256 HLAmatches2;
                bool donorMatch;

                // Checks certificate recipient
                if (
                    certificates[index].recipientHealth.age -
                        certificates[i].donorHealth.age <
                    20
                ) {
                    ageMatch1 = true;
                }

                if (
                    keccak256(
                        bytes(certificates[index].recipientHealth.bloodType)
                    ) == keccak256(bytes(certificates[i].donorHealth.bloodType))
                ) {
                    bloodTypeMatch1 = true;
                }

                if (
                    keccak256(
                        bytes(certificates[index].recipientHealth.HLAA1)
                    ) == keccak256(bytes(certificates[i].donorHealth.HLAA1))
                ) {
                    HLAmatches1++;
                }

                if (
                    keccak256(
                        bytes(certificates[index].recipientHealth.HLAA2)
                    ) == keccak256(bytes(certificates[i].donorHealth.HLAA1))
                ) {
                    HLAmatches1++;
                }

                if (
                    keccak256(
                        bytes(certificates[index].recipientHealth.HLAB1)
                    ) == keccak256(bytes(certificates[i].donorHealth.HLAB1))
                ) {
                    HLAmatches1++;
                }

                if (
                    keccak256(
                        bytes(certificates[index].recipientHealth.HLAB2)
                    ) == keccak256(bytes(certificates[i].donorHealth.HLAB2))
                ) {
                    HLAmatches1++;
                }

                if (
                    keccak256(
                        bytes(certificates[index].recipientHealth.HLADR1)
                    ) == keccak256(bytes(certificates[i].donorHealth.HLADR1))
                ) {
                    HLAmatches1++;
                }

                if (
                    keccak256(
                        bytes(certificates[index].recipientHealth.HLADR2)
                    ) == keccak256(bytes(certificates[i].donorHealth.HLADR2))
                ) {
                    HLAmatches1++;
                }

                if (
                    keccak256(
                        bytes(certificates[index].recipientHealth.HLADQ1)
                    ) == keccak256(bytes(certificates[i].donorHealth.HLADQ1))
                ) {
                    HLAmatches1++;
                }

                if (
                    keccak256(
                        bytes(certificates[index].recipientHealth.HLADQ2)
                    ) == keccak256(bytes(certificates[i].donorHealth.HLADQ2))
                ) {
                    HLAmatches1++;
                }

                if (
                    certificates[index].recipientHealth.PRA -
                        certificates[i].donorHealth.PRA <
                    20
                ) {
                    PRAmatch1 = true;
                }

                if (
                    HLAmatches1 > 4 && ageMatch1 && bloodTypeMatch1 && PRAmatch1
                ) {
                    recipientMatch = true;
                }

                // Check certificate donor

                if (
                    certificates[index].donorHealth.age -
                        certificates[i].recipientHealth.age <
                    20
                ) {
                    ageMatch2 = true;
                }

                if (
                    keccak256(
                        bytes(certificates[index].donorHealth.bloodType)
                    ) ==
                    keccak256(bytes(certificates[i].recipientHealth.bloodType))
                ) {
                    bloodTypeMatch2 = true;
                }

                if (
                    keccak256(bytes(certificates[index].donorHealth.HLAA1)) ==
                    keccak256(bytes(certificates[i].recipientHealth.HLAA1))
                ) {
                    HLAmatches2++;
                }

                if (
                    keccak256(bytes(certificates[index].donorHealth.HLAA2)) ==
                    keccak256(bytes(certificates[i].recipientHealth.HLAA2))
                ) {
                    HLAmatches2++;
                }

                if (
                    keccak256(bytes(certificates[index].donorHealth.HLAB1)) ==
                    keccak256(bytes(certificates[i].recipientHealth.HLAB1))
                ) {
                    HLAmatches2++;
                }

                if (
                    keccak256(bytes(certificates[index].donorHealth.HLAB2)) ==
                    keccak256(bytes(certificates[i].recipientHealth.HLAB2))
                ) {
                    HLAmatches2++;
                }

                if (
                    keccak256(bytes(certificates[index].donorHealth.HLADR1)) ==
                    keccak256(bytes(certificates[i].recipientHealth.HLADR1))
                ) {
                    HLAmatches2++;
                }

                if (
                    keccak256(bytes(certificates[index].donorHealth.HLADR2)) ==
                    keccak256(bytes(certificates[i].recipientHealth.HLADR2))
                ) {
                    HLAmatches2++;
                }

                if (
                    keccak256(bytes(certificates[index].donorHealth.HLADQ1)) ==
                    keccak256(bytes(certificates[i].recipientHealth.HLADQ1))
                ) {
                    HLAmatches2++;
                }

                if (
                    keccak256(bytes(certificates[index].donorHealth.HLADQ2)) ==
                    keccak256(bytes(certificates[i].recipientHealth.HLADQ2))
                ) {
                    HLAmatches2++;
                }

                if (
                    certificates[index].donorHealth.PRA -
                        certificates[i].recipientHealth.PRA <
                    20
                ) {
                    PRAmatch2 = true;
                }

                if (
                    HLAmatches1 > 4 && ageMatch1 && bloodTypeMatch1 && PRAmatch1
                ) {
                    recipientMatch = true;
                }

                if (
                    HLAmatches2 > 4 && ageMatch2 && bloodTypeMatch2 && PRAmatch2
                ) {
                    donorMatch = true;
                }

                if (recipientMatch && donorMatch) {
                    return (
                        string(
                            abi.encodePacked(
                                certificates[i].donorID,
                                certificates[i].recipientID
                            )
                        )
                    );
                }
            }
        }
    }
}
