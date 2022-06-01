// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Bcorrupt {

    // State Variables
    mapping(string => Complaintinfo) complaintInfo;
    mapping(string => uint) numberOfComplaints;
    uint numberOfComplaintRegistered;
    mapping(string => Complaintinfo[]) infos;

    // @Struct - to define complaint staructure 
    struct Complaintinfo {
        uint numberOfComplaintAgainstBribeTaker;
        string bribeTakerName;
        uint brirbeAmount;
        string briberDepartment;
        string briberState;
        string additionalCommentsForBriber;
    }

    // @Event - to emit after succesfull compplaint registration
    event ComplaintRegisteded(string _name,
                                uint _amountAsked,
                                string _additionalCommentsForBriber,
                                uint _count
                                );
    
    // @Function - To registed the complaint
    function registerComplaint(string memory _name,
                                uint _amountAsked,string memory _department,
                                string memory _state,string memory _additionalCommentsForBriber
                                ) public {

        numberOfComplaintRegistered++;
        uint count = numberOfComplaints[_name];
        numberOfComplaints[_name] = count +1;
        // Intialize Structs
        Complaintinfo storage compliant = complaintInfo[_name];
        compliant.numberOfComplaintAgainstBribeTaker = count + 1;
        compliant.brirbeAmount = _amountAsked;
        compliant.briberDepartment = _department;
        compliant.briberState = _state;
        compliant.additionalCommentsForBriber = _additionalCommentsForBriber;
        //Emit event after complaint registration
        emit ComplaintRegisteded(_name,_amountAsked,_additionalCommentsForBriber,count);
        // adding complaint into array which is used to show all complaints at once 
        infos[_name].push(compliant);
    }

    // @Function - To fetch latest complaint against briber
    function getLatestComplaintAgainstBriber(string memory _bribeTakerName) public view returns(
                                                uint TotalComplaints_,
                                                uint Amount_,
                                                string memory Department_,
                                                string memory State_,
                                                string memory additionalInfo_){
        Complaintinfo storage cI =  complaintInfo[_bribeTakerName];                            
            return ( 
                    cI.numberOfComplaintAgainstBribeTaker,
                    cI.brirbeAmount,
                    cI.briberDepartment,
                    cI.briberState,
                    cI.additionalCommentsForBriber  
                ); 
    }

    // @Function - To fetch all complaints against briber
    function getAllComplaintsAgainstBriber(string memory _bribeTakerName) public view returns(
                                            Complaintinfo[] memory
                                            ){
        return infos[_bribeTakerName];
    }

    // @Function - To get all registeded complaints
    function totalRegisteredComplaint() public view returns(uint){
        return numberOfComplaintRegistered;
    }

}
