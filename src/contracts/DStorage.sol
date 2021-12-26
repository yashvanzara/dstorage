pragma solidity ^0.5.0;

contract DStorage {

  // Name
  string public name = "DStorage";
  // Number of files
  uint public fileCount = 0;
  // Mapping fileId=>Struct 
  mapping( uint => File ) public files;

  // Struct
  struct File {
    uint fileId;
    string fileHash;
    uint fileSize;
    string fileType;
    string fileName;
    string fileDescription;
    uint uploadTime;
    address payable uploader;
  }

  // Event
  event FileUploaded (
    uint fileId,
    string fileHash,
    uint fileSize,
    string fileType,
    string fileName,
    string fileDescription,
    uint uploadTime,
    address payable uploader
  );

  constructor() public {
  }

  function uploadFile(string memory _fileHash, uint _fileSize, string memory _fileType, string memory _fileName, string memory _fileDescription) public {
    // Make sure the file hash exists
    // Should be an expression that evaluates to true or false
    require(bytes(_fileHash).length > 0);
    require(bytes(_fileType).length > 0);
    require(bytes(_fileName).length > 0);
    require(bytes(_fileDescription).length > 0);
    require(msg.sender != address(0));
    require(_fileSize > 0);

    // Trigger an event    
    fileCount = fileCount + 1;
    files[fileCount] = File(fileCount, _fileHash, _fileSize, _fileType, _fileName, _fileDescription, now, msg.sender);
    emit FileUploaded(fileCount, _fileHash, _fileSize, _fileType, _fileName, _fileDescription, now, msg.sender);
  }
}