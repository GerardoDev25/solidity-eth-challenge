// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

    address public owner;

   struct Ability {
        string name;
        string description;
    }

    struct Pokemon {
        uint id;
        string name;
        string urlImg;
        Ability[] abilities;
    }

    Pokemon[] private pokemons;

    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;

    event eventNewPokemon(Pokemon pokemon);

    constructor(){
        owner = msg.sender;
    }

    modifier onlyOwner {
       require(msg.sender == owner, "only the owner can do this action");
       _;
    }

     function createPokemon (
        uint _id,
        string memory _name,
        string memory _urlImg,
        string[] memory _skillNames,
        string[] memory _skillDescriptions
        ) public onlyOwner{

        require(_id > 0, "the id shout be major that 0");
        require(bytes(_name).length > 2, "the name must be greater than two characters");

        pokemons.push();
        uint256 index = pokemons.length - 1;
        
        pokemons[index].id = _id;
        pokemons[index].name = _name;
        pokemons[index].name = _urlImg;

        addAbilities(_skillNames, _skillDescriptions, index);

        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;

        // emit event
        emit eventNewPokemon(pokemons[index]);
    }

    function addAbilities(string[] memory _skillNames, string[] memory _skillDescriptions, uint index) private {
        for(uint i; i < _skillNames.length; i++){
            pokemons[index].abilities.push(Ability(_skillNames[i], _skillDescriptions[i]));
        }
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
      return pokemons;
    }

}
