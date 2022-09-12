//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Strings.sol";

contract Bank {
    uint256 pyt = 1;
    struct BankTransaction {
        string payment_identifier;
        address client_identifier;
        address recipient_identifier;
        uint256 amount;
        uint256 time;
        string note_pyt;
        bytes20 pyt_hash;
    }
    mapping(string => BankTransaction) public bank_ts;
    mapping(address => string[]) public ts;

    function AddPayment(
        address payable _recepient,
        uint256 _amount,
        _note,
        string memory
    ) {
        string memory _payment_identifier = string(
            abi.encodedPacked("payment_identifier", "+", Strings.toString(pyt))
        );
        uint256 _time = block.time;
        bytes20 _pyt_hash = ripemd160(
            abi.encodePacked(
                _payment_identifier,
                msg.sender,
                _recipient_identifier,
                _amount,
                _time
            )
        );
        BankTransaction memory transaction = BankTransaction(
            _payment_identifier,
            msg.sender,
            _recipient_identifier,
            _amount,
            _time,
            _note,
            _pyt_hash
        );
        bank_ts[_payment_identifier] = transaction;
        ts[msg.sender].push(_payment_identifier);

        pyt += 1;
    }

    function payment_Info(string memory _payment_identifier)
        public
        view
        returns (
            string memory,
            address,
            uint256,
            uint256,
            string memory,
            bytes20
        )
    {
        return (
            bank_ts[_payment_identifier].payment_identifier,
            bank_ts[_payment_identifier].client_identifier,
            bank_ts[_payment_identifier].recipient_identifier,
            bank_ts[_payment_identifier].amount_identifier,
            bank_ts[_payment_identifier].time_identifier,
            bank_ts[_payment_identifier].note_pyt,
            bank_ts[_payment_identifier].pyt_hash
        );
    }

    function getpayments(address payable _client_identifier)
        public
        view
        returns (string[] memory)
    {
        return ts[_client_identifier];
    }
}
