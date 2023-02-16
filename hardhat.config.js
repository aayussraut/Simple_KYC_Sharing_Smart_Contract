require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  networks: {
    goerli: {
      url: "https://eth-goerli.g.alchemy.com/v2/O6CcBp7V0xAP9Y0F-2WSDfD2PPqeMp2D",
      accounts: [
        "b9bc80b2c8d1e8e4563d50de1d6800739f2d3f74c69f364f63f03e2e24de56df",
      ],
    },
  },
};

// https://eth-goerli.g.alchemy.com/v2/O6CcBp7V0xAP9Y0F-2WSDfD2PPqeMp2D
