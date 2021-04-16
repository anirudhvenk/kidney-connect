const TodoList = artifacts.require("./CertificateLedger.sol");

module.exports = function (deployer) {
    deployer.deploy(TodoList);
};
