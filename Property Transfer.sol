pragma solidity >=0.4.0 <0.7.0;

contract propertytransfer{
    
    //define and initialising the value
    
    address owner;
    uint public propertyCount=0;
    uint public transferCount=0;
    
    //creation of the array
    
    propertytransfer[] public Propertytransfer;
    
   
    //creation of the modifier
    
    /*modifier onlyOwner(){
        require(msg.sender==owner);
        _;
    }*/
    //creation of the mapping
    
    mapping(uint => propertyowner) public Propertyowner;
    mapping(address => bool) public Verified_owner;
    
    //creation of the structure
    
    struct propertyowner{
        uint _id;
        string _location;
        uint _area;
        string _propertyname;
        uint256 _propertycost;
        uint propertycount;
       }
      
      struct propertytransfer{
          address _from;
          address _to;
      }
      
      
      //creation of the event
    
      event allotmentEvent(
          uint indexed Personid
        );
        
        //creation of the dummy data in the constructor
        
        constructor()public
        {
            owner=msg.sender;
            addProperty("Mumbai",100,"Flat",123);
            addProperty("Uttarpradesh",115,"Shop",100);
            addProperty("Rajasthan",123,"Flat",200);
        }
        
        
    //defining the mapping
        
    function addProperty(string memory _location,uint _area,string memory _propertyname,uint256 _propertycost) private
    {
        
        propertyCount +=1;
        Propertyowner[propertyCount]=propertyowner(propertyCount,_location,_area,_propertyname,_propertycost,0);
        
        }
        
    //defining the array
    
    function addtransfer(address _from,address _to)public
    {   
        //require previous owner cannot sell again his/her particular property once its sold
        
        require(!Verified_owner[msg.sender]);
        
        Propertytransfer.push(propertytransfer(_from,_to));
        transferCount +=1;
        
    }
    
    //defining function
  
    function Property(uint _Personid) public
    {
         //require previous owner cannot sell again his/her particular property once its sold
          
        require(!Verified_owner[msg.sender]);
          
        //require valid owner
    
       require(_Personid >0 && _Personid <= propertyCount);
       require(_Personid >0 && _Personid <= transferCount);
       
       //update propertycount
        Propertyowner[_Personid].propertycount ++;
        
        //record of the owner that the patient has entered the correct values with the correct address
        
         Verified_owner[msg.sender]=true;
        
        //emition of the event
        
        emit allotmentEvent(_Personid);
        
    }
}