 pragma solidity >= 0.7.0 < 0.9.0;

//  SPDX-License-Identifier:MIT

contract simple_storage{
    uint store_data;

    function set(uint _store_data) public {
        store_data = _store_data;
    }
    function get() public view returns(uint){
        return store_data;
    }
}