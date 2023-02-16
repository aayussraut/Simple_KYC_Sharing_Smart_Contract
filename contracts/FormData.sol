//SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;

contract FormData {
    // Structure to store form data of a user
    struct UserData {
        string name;
        uint256 age;
        string address1;
        mapping(address => bool) approvedReceivers;
    }

    mapping(address => bool) public isAsking;
    mapping(address => address) public bankAddress;

    // Mapping to store form data of all users
    mapping(address => UserData) public userData;

    // Event to log form data storage
    event FormDataStored(address user);
    event DataAccessRequested(address user, address bank);
    event DataAccessGranted(address bank);
    event DataAccessDenied(address bank);

    // Function to store form data of a user
    function storeFormData(
        string memory _name,
        uint256 _age,
        string memory _address
    ) public {
        userData[msg.sender].name = _name;
        userData[msg.sender].age = _age;
        userData[msg.sender].address1 = _address;
        isAsking[msg.sender] = false;
        emit FormDataStored(msg.sender);
    }

    //funfction to show the request to user
    // function showRequest(address _bank) public view  {
    //     return userData[_bank].approvedReceivers[msg.sender];
    // }

    // Function to request form data access of a user
    function requestDataAccess(address _userAddress) public returns (bool) {
        if (userData[_userAddress].approvedReceivers[msg.sender]) {
            isAsking[_userAddress] = false;
            return true;
        } else {
            isAsking[_userAddress] = true;
            bankAddress[_userAddress] = msg.sender;
            emit DataAccessRequested(_userAddress, msg.sender);
            return false;
        }
    }

    //function to get the request status from user side
    function getIsAsking() public view returns (bool, address) {
        return (isAsking[msg.sender], bankAddress[msg.sender]);
    }

    // Function to allow a user to send form data to another user
    function allowAccess(address _receiver) public {
        userData[msg.sender].approvedReceivers[_receiver] = true;
        isAsking[msg.sender] = false;
        // getFormData();
        emit DataAccessGranted(_receiver);
    }

    // Function to revoke access for a user
    function revokeAccess(address _receiver) public {
        userData[msg.sender].approvedReceivers[_receiver] = false;
        isAsking[msg.sender] = false;
        emit DataAccessDenied(_receiver);
    }

    // Function to retrieve form data of a user
    function getFormData(address _user)
        public
        view
        returns (
            string memory,
            uint256,
            string memory
        )
    {
        if (_user == msg.sender) {
            return (
                userData[_user].name,
                userData[_user].age,
                userData[_user].address1
            );
        }
        require(
            userData[_user].approvedReceivers[bankAddress[_user]],
            "Access not allowed"
        );
        return (
            userData[_user].name,
            userData[_user].age,
            userData[_user].address1
        );
    }
}
