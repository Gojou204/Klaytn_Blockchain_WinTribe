// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 < 0.9.0;

interface ICertificate {
    function setOwnerInfo(string memory _cccd, string memory _name, string memory _sex, string memory _birthday, string memory _Address) external;
    function setVehicleInfo(
        string memory _licensePlate,
        string memory _model,
        string memory _engine_N,
        string memory _classis_N,
        string memory _brand,
        uint _year,
        string memory _color,
        uint _capacity,
        string memory _status
    ) external;
    function registerVehicle(
        string memory _name,
        string memory _licensePlate,
        string memory _model,
        string memory _brand,
        uint _year,
        string memory _color,
        uint _capacity,
        string memory status
    ) external;
}

contract Certificate is ICertificate{
    struct ownerInfo {
        address id;
        string cccd;
        string name;
        string sex;
        string birthday;
        string Address;
    }
    struct vehicleInfo {
        address owner;
        string licensePlate;
        string model;
        string engine_N;
        string classis_N;
        string brand;
        uint   year;
        string color;
        uint   capacity;
        string status;
    }
    struct register {
        address idOwner;
        string name;
        string licensePlate;
        string model;
        string brand;
        uint   year;
        string color;
        uint   capacity;
        string status;
    }


    mapping(address => ownerInfo) Owner_Information;
    mapping(string => vehicleInfo) Vehicle_Information;
    mapping(address => register) Register_Vehicle;

    function setVehicleInfo(
        string memory _licensePlate,
        string memory _model,
        string memory _engine_N,
        string memory _classis_N,
        string memory _brand,
        uint _year,
        string memory _color,
        uint _capacity,
        string memory _status
    ) public override {
        Vehicle_Information[_licensePlate] = vehicleInfo({
            owner: msg.sender,
            licensePlate: _licensePlate,
            model: _model,
            engine_N: _engine_N,
            classis_N: _classis_N,
            brand: _brand,
            year: _year,
            color: _color,
            capacity: _capacity,
            status: _status
        });
    }

    function getVehicleInfo(string memory _licensePlate) public view
    returns(address Owner,string memory licensePlate, string memory model, string memory engine_N, string memory classis_N,
        string memory brand, uint year, string memory color, uint capacity, string memory status)  {
            vehicleInfo memory info = Vehicle_Information[_licensePlate];
            return (info.owner, info.licensePlate, info.model, info.engine_N, info.classis_N, info.brand, info.year, info.color, info.capacity, info.status);
        }

    function setOwnerInfo(string memory _cccd, string memory _name, string memory _sex, string memory _birthday, string memory _Address) public override{
        Owner_Information[msg.sender] = ownerInfo({
            id: msg.sender,
            cccd: _cccd,
            name: _name,
            sex: _sex,
            birthday: _birthday,
            Address: _Address
        });
    }

    function getOwnerInfo(address _idOwner) public view 
    returns(string memory cccd, string memory name, string memory sex, string memory birthday, string memory Address){
        ownerInfo memory info = Owner_Information[_idOwner];
        return (info.cccd, info.name, info.sex, info.birthday, info.Address);
    }

    function registerVehicle(
        string memory _name,
        string memory _licensePlate,
        string memory _model,
        string memory _brand,
        uint _year,
        string memory _color,
        uint _capacity,
        string memory _status
    ) public override {
        Register_Vehicle[msg.sender] = register({
            idOwner: msg.sender,
            name: _name,
            licensePlate: _licensePlate,
            model: _model,
            brand: _brand,
            year: _year,
            color: _color,
            capacity: _capacity,
            status: _status
        });
    }
}