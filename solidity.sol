pragma solidity >=0.5.0 <0.9.0;
contract lottery {
    address public manager;//stores the address of manager 
    address payable[] public participants;//payable to transfer the eth.as a array type

    constructor() 
    {
        manager=msg.sender; //global variable//
    }
    receive() external payable // receive only used once in contract with external//no arguements can be passed
    {
        require(msg.value==1 ether);//same as if else codition for participation
        participants.push(payable(msg.sender));//to transfer address of participants to dynamic array

    }
    function getbalance() public view returns(uint)
    {
        require(msg.sender==manager); 
        return  address(this).balance;
    }
    function random() public view returns(uint)//lottery
    {
        return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,participants.length)));//hashing algorithm

    }
    function selectwinner() public//selection of winner
    {
        require(msg.sender==manager);
        require(participants.length>=3);//length of paticipants
        uint r=random();
        address payable winner;
        uint index=r%participants.length;//random function called
        winner = participants[index];//address of participants
        winner.transfer(getbalance());
        participants = new address payable[](0);

    }

} 