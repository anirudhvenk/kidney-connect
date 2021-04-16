pragma solidity ^0.5.16;

contract CertificateLedger {
    uint256 certCount = 0;
    struct Certificate {
        string CertificateID;
        // uint256 RecipientID;
        // uint256 RecipientHealth;
        // uint256 DonorID;
        // uint256 DonorHealth;
        // address DoctorSig;
        // uint256 Contact;
        // uint256 TimeStamp;
        // bool ValidPair;
    }

    mapping(uint256 => Certificate) public certificates;

    // event certificateCreated(Certificate);
    event matchFound(string certificateID);

    function createCertificate(string memory _content) public {
        certificates[certCount] = Certificate(_content);
        // emit certificateCreated(certificates[certCount]);
        certCount++;
    }

    function findMatch(string memory _certificateID)
        public
        returns (mapping(uint256 => Certificate))
    {
        // for (uint256 j = 0; j < certCount; j++) {
        // }
        // emit matchFound(_certificateID);
        // uint256[] x = [1, 2, 3];
        string[] ids = ["a", "b", "c"];
        return (ids);
    }
}
