pragma solidity ^0.5.16;
pragma experimental ABIEncoderV2;

contract CertificateLedger {
    uint256 certCount = 0;
    struct Certificate {
        string recipientID;
        // uint256 RecipientHealth;
        // uint256 DonorID;
        // uint256 DonorHealth;
        address signature;
        Health recipientHealth;

        // uint256 Contact;
        // uint256 TimeStamp;
        // bool ValidPair;
    }

    struct Health {
        uint256 age;
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
        address _signature,
        string memory _recipientID,
        Health memory _recipientHealth
    ) public {
        certificates[certCount] = Certificate(
            _recipientID,
            _signature,
            _recipientHealth
        );
        certCount++;
    }

    // mapping(uint256 => Certificate) public certificates;

    // // event certificateCreated(Certificate);
    // event matchFound(string certificateID);

    // function createCertificate(string memory _content) public {
    //     CertificateLedger cert = Certificate(_content);
    //     // emit certificateCreated(certificates[certCount]);
    //     certCount++;
    // }

    // function findMatch(address addr) external returns (uint256) {
    //     // for (uint256 j = 0; j < certCount; j++) {
    //     // }
    //     // emit matchFound(_certificateID);
    //     // uint256[] x = [1, 2, 3];
    //     return (10);
    // }
}

// contract CertificateLedgerWrapper {
//     uint256 certificates = 10;
// }
