// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract Articles
{
    struct Infos {
        string author;
        string title;
        string content;
        uint256 timestamp;
    }
    address[] users;
    mapping(address => string) usersNames;
    mapping(address => Infos[]) articles;

    function isExist(address useraddress) private view returns (bool) {
        for (uint i = 0; i < users.length; i++)
        {
            if (users[i] == useraddress)
                return true;
        }
        return false;
    }

    function addUserName(string memory _name) public {
        usersNames[msg.sender] = _name;
    }
    
    function getUserName(address _userAddress) public view returns (string memory) {
        return usersNames[_userAddress];
    }

    function addArticle(string memory title, string memory content, uint256 timestamp) public {
        Infos memory article = Infos(usersNames[msg.sender], title, content, timestamp);
        if (!isExist(msg.sender))
            users.push(msg.sender);
        articles[msg.sender].push(article);
    }

    function getArticles(address userAddress) public view returns (Infos[] memory) {
        return  articles[userAddress];
    }

    function articlesCount() private view returns (uint256) {
        uint256 count = 0;
        for (uint i = 0; i < users.length; i++)
            count += articles[users[i]].length;
        return count;
    }

    function getAllArticles() public view returns (Infos[] memory) {
        uint256 articlesLength = articlesCount();
        uint256 indexCount = 0;
        Infos[] memory allArticles = new Infos[](articlesLength);
        for (uint i = 0; i < users.length; i++)
        {
            for (uint j = 0; j < articles[users[i]].length; j++)
            {
                allArticles[indexCount] = articles[users[i]][j];
                indexCount++;
            }
        }
        return allArticles;     
    }
}



