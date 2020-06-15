pragma solidity ^0.5.0;

contract DCToken {

	string public name = 'DC Token';
	string public symbol = 'DC';
	string public standard = 'DC Token v1.0';
	uint256 public totalSupply;

	event Transfer(
		address indexed _from,
		address indexed _to,
		uint256 _value
	);

	event Approval(
		address indexed _owner,
		address indexed _spender,
		uint256 _value
	);

	mapping(address => uint256) public balanceOf;
	// nested mapping account A approves account B to spend so many tokens
	//                account A approves account C to spend so many tokens
	//              and so on.....
	mapping(address => mapping(address => uint256)) public allowance;

	constructor(uint256 _initialSupply) public {
		// allocate the initial supply of tokens
		balanceOf[msg.sender] = _initialSupply;
		totalSupply = _initialSupply;
	}


	function transfer(address _to, uint256 _value) public  returns (bool success) {
		require(balanceOf[msg.sender] >= _value);
		// Transfer the balance
		balanceOf[msg.sender] -= _value;
		balanceOf[_to] += _value;
		// Transfer event
		emit Transfer(msg.sender, _to, _value);
		return true;
	}

	// approve	
	function approve(address _spender, uint256 _value) public returns (bool success) {
		// allowance
		allowance[msg.sender][_spender] = _value;
		// approve the event
		emit Approval(msg.sender, _spender, _value);

		return true;
	}

	// transferFrom
	function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {

		// Require _from account has enough tokens
		require(_value <= balanceOf[_from]);

		// Require allowance is big enough
		require(_value <= allowance[_from][msg.sender]);

		// Change the balance
		balanceOf[_from] -= _value;
		balanceOf[_to] += _value;

		// Update the allowance
		allowance[_from][msg.sender] -= _value;

		// emit Transfer event
		emit Transfer(_from, _to, _value);
		// return boolean
		return true;
	}

}