// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/**
        /$$$$$$            /$$$$$$$  /$$$$$$$$ /$$$$$$        /$$$$$$$  /$$        /$$$$$$   /$$$$$$  /$$$$$$$$
        /$$$_  $$          | $$__  $$|__  $$__//$$__  $$      | $$__  $$| $$       /$$__  $$ /$$__  $$| $$_____/
        | $$$$\ $$ /$$   /$$| $$  \ $$   | $$  | $$  \__/      | $$  \ $$| $$      | $$  \ $$| $$  \__/| $$      
        | $$ $$ $$|  $$ /$$/| $$$$$$$    | $$  | $$            | $$$$$$$/| $$      | $$$$$$$$| $$      | $$$$$   
        | $$\ $$$$ \  $$$$/ | $$__  $$   | $$  | $$            | $$____/ | $$      | $$__  $$| $$      | $$__/   
        | $$ \ $$$  >$$  $$ | $$  \ $$   | $$  | $$    $$      | $$      | $$      | $$  | $$| $$    $$| $$      
        |  $$$$$$/ /$$/\  $$| $$$$$$$/   | $$  |  $$$$$$/      | $$      | $$$$$$$$| $$  | $$|  $$$$$$/| $$$$$$$$
        \______/ |__/  \__/|_______/    |__/   \______/       |__/      |________/|__/  |__/ \______/ |________/


        Built and opensourced by Fappablo#8171
        https://github.com/fappablo/0xbitcoin-space
        https://github.com/fappablo/0xbitcoin-place-backend
        https://github.com/fappablo/0xbitcoin-space-contract        

        DISCLAIMER: I take no responsability for the content displayed on the canvas                                                                                                                                                                                                                                                                                                                                                            
*/

contract The0xBitcoinSpace is Ownable {
    address internal acceptedCurrency = 0x71B821aa52a49F32EEd535fCA6Eb5aa130085978;
    address internal devWallet = 0x995e3e70f983D231a212c2A7210FC36a5B70CC39;
    uint256 internal pricePerPixel = 1000000;

    constructor() {}

    event PixelsPlaced(uint256[] x, uint256[] y, uint256[] color);

    function placePixels(
        uint256[] calldata x,
        uint256[] calldata y,
        uint256[] calldata color
    ) public {
        uint256 len = x.length;

        require(
            y.length == len && color.length == len,
            "Different argument dimensions"
        );

        require(
            IERC20(acceptedCurrency).transferFrom(
                _msgSender(),
                devWallet,
                pricePerPixel * len
            ),
            "User must have paid"
        );

        emit PixelsPlaced(x, y, color);
    }

    function updatePrice(uint256 newPrice) external onlyOwner {
        require(newPrice > 0);
        pricePerPixel = newPrice;
    }

    //Got to get hacked every now and then
    function updateDevWallet(address newWallet) external onlyOwner {
        devWallet = newWallet;
    }

    //0xBTC V2?
    function updateAcceptedCurrency(address newAcceptedCurrency)
        external
        onlyOwner
    {
        acceptedCurrency = newAcceptedCurrency;
    }
}
