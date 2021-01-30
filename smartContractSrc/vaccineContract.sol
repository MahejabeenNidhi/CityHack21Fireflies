pragma solidity 0.5.1;

contract VaccineContract{
    
    
    mapping(uint=>Vaccine) public vaccines;
    mapping(uint=>uint) public patientToVaccines;
    
    mapping(string=>address) private wallets;
    
    mapping(address=>uint) private balancesWallet;
    
    address payable wallet;
    constructor(address payable _wallet) public {
        wallet = _wallet;
    }
    
     uint256 public vaccineCount;
     
     address owner;
    struct Vaccine{
        bool isDeliveredFirstShot; 
        bool isDeliveredSecondShot;
        uint patientID;
        string  company;
        
    }
      modifier onlyOwner(){
        require (msg.sender == owner);
        _;
    }
    
    function addCompanyWallet(string memory _companyName,address _address) private{
       wallets[_companyName] = _address;  
    }
    
    function addVaccine(uint _patientID, string memory  _company) public onlyOwner {
     
    
     vaccines[vaccineCount] = Vaccine(false,false,_patientID,_company);
     incrementCount();
     patientToVaccines[_patientID] - vaccineCount;
     
     
    }
    
    
    
    function deliverFirstShot(uint _patientID) public{
        uint  vaccineID;
        vaccineID = patientToVaccines[_patientID];
        vaccines[vaccineID].isDeliveredFirstShot=true;
        
    }
    function deliverSecondShot(uint _patientID) public{
        uint  vaccineID;
        vaccineID = patientToVaccines[_patientID];
        vaccines[vaccineID].isDeliveredSecondShot=true;
        
        Vaccine memory _vaccine = vaccines[vaccineID];
        
        if(_vaccine.isDeliveredSecondShot && _vaccine.isDeliveredSecondShot){
            payForVaccine(_vaccine.company);
        }
        
    }
    
    function payForVaccine(string memory  _company) public payable{
        address  _address = wallets[_company];
        balancesWallet[_address]+=1;
        wallet.transfer(1);
        
    
    }
    function incrementCount() internal{
        vaccineCount+=1;
    }
}pragma solidity 0.5.1;

contract VaccineContract{
    
    
    mapping(uint=>Vaccine) public vaccines;
    mapping(uint=>uint) public patientToVaccines;
    
    mapping(string=>address) private wallets;
    
    mapping(address=>uint) private balancesWallet;
    
    address payable wallet;
    constructor(address payable _wallet) public {
        wallet = _wallet;
    }
    
     uint256 public vaccineCount;
     
     address owner;
    struct Vaccine{
        bool isDeliveredFirstShot; 
        bool isDeliveredSecondShot;
        uint patientID;
        string  company;
        
    }
      modifier onlyOwner(){
        require (msg.sender == owner);
        _;
    }
    
    function addCompanyWallet(string memory _companyName,address _address) private{
       wallets[_companyName] = _address;  
    }
    
    function addVaccine(uint _patientID, string memory  _company) public onlyOwner {
     
    
     vaccines[vaccineCount] = Vaccine(false,false,_patientID,_company);
     incrementCount();
     patientToVaccines[_patientID] - vaccineCount;
     
     
    }
    
    
    
    function deliverFirstShot(uint _patientID) public{
        uint  vaccineID;
        vaccineID = patientToVaccines[_patientID];
        vaccines[vaccineID].isDeliveredFirstShot=true;
        
    }
    function deliverSecondShot(uint _patientID) public{
        uint  vaccineID;
        vaccineID = patientToVaccines[_patientID];
        vaccines[vaccineID].isDeliveredSecondShot=true;
        
        Vaccine memory _vaccine = vaccines[vaccineID];
        
        if(_vaccine.isDeliveredSecondShot && _vaccine.isDeliveredSecondShot){
            payForVaccine(_vaccine.company);
        }
        
    }
    
    function payForVaccine(string memory  _company) public payable{
        address  _address = wallets[_company];
        balancesWallet[_address]+=1;
        wallet.transfer(1);
        
    
    }
    function incrementCount() internal{
        vaccineCount+=1;
    }
}
