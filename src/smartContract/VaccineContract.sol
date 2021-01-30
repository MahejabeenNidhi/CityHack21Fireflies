pragma solidity 0.5.1;

contract VaccineContract{
    
    
    mapping(uint=>Vaccine) public vaccines;
    mapping(uint=>uint) public patientToVaccines;
    
    mapping(string=>address) private wallets;
    mapping(address=>uint) private balancesWallet;
    
    mapping(uint=>Vaccine) public vaccinatorsToVaccines;
    mapping(uint=>Vaccinator) public vaccinators;
    
    address payable wallet;
    
    constructor(address payable _wallet) public {
        
        wallet = _wallet;
        
    }
    
    
    
     uint256 public vaccineCount;
     uint256 public vaccinatorCount;
     
     
     address owner;
    struct Vaccine{
        
        bool isDeliveredFirstShot; 
        bool isDeliveredSecondShot;
        uint patientID;
        string  company;
        
    }
    struct Vaccinator{
        
        string firstName;
        string lastName;
        uint256 id;
        
    }
    
    /*checks if the transaction perfomed by the owner, or the one who deployed contract*/
      modifier onlyOwner(){
          
        require (msg.sender == owner);
        _;
    }
    
    /* Adds wallet to the mapping */
    function addCompanyWallet(string memory _companyName,address _address) private{
        
       wallets[_companyName] = _address;  
    }
    
    function addVaccine(uint _patientID, string memory  _company) public onlyOwner {
        
     vaccines[vaccineCount] = Vaccine(false,false,_patientID,_company);
     incrementVaccineCount();
     patientToVaccines[_patientID] - vaccineCount;
     
    }
    
      function incrementVaccineCount() internal{
          
        vaccineCount+=1;
    }
    
    function addVaccinator(string memory _firstName, string memory _lastName) public{
        
        vaccinators[vaccinatorCount] = Vaccinator(_firstName,_lastName,vaccinatorCount);
        incrementVaccinatorCount();
        
    } 
    
    function incrementVaccinatorCount() internal {
        
        vaccinatorCount+=1;
        
    }
    
    function deliverFirstShot(uint _patientID, uint _vaccinatorID) public{
        
        uint  vaccineID;
        vaccineID = patientToVaccines[_patientID];
        vaccines[vaccineID].isDeliveredFirstShot=true;
        
        vaccinatorsToVaccines[_vaccinatorID]=vaccines[vaccineID];
        
        
    }
    
    /*After the completion of the Second Shot, contract check is both shots were 
    delivered and the then pays to the manufacturer by transferring
    ethereum to their wallet */
    
    function deliverSecondShot(uint _patientID,uint _vaccinatorID) public{
        
        uint  vaccineID;
        vaccineID = patientToVaccines[_patientID];
        vaccines[vaccineID].isDeliveredSecondShot=true;
        vaccinatorsToVaccines[_vaccinatorID]=vaccines[vaccineID];
         
        Vaccine memory _vaccine = vaccines[vaccineID];
        
        if(_vaccine.isDeliveredSecondShot && _vaccine.isDeliveredSecondShot){
            payForVaccine(_vaccine.company);
        }
        
    }
    /*transfer ethereum to the wallet of the manufacturer*/
    function payForVaccine(string memory  _company) public payable{
        address  _address = wallets[_company];
        balancesWallet[_address]+=1;
        wallet.transfer(1);
        
    }
  
}
