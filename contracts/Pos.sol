// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Pos {
    //Contract Connection

    string public connectionMessage = "Connection Success Babe!";

    function getConnectionMessage() public view returns (string memory) {
        return connectionMessage;
    }

    function setConnectionMessage(string memory _connectionMessage) public {
        connectionMessage = _connectionMessage;
    }

    //Product

    struct Product {
        uint256 id;
        string name;
        uint256 price;
        uint256 stock;
        bool isSell;
    }

    mapping(string => Product) products;

    uint256 productId = 0;

    function getProductInfo(string memory _barcode)
        public
        view
        returns (Product memory)
    {
        return products[_barcode];
    }

    function addProduct(
        string memory _barcode,
        string memory _name,
        uint256 _price,
        uint256 _stock,
        bool _isSell
    ) public returns (bool) {
        if (products[_barcode].id != 0) {
            revert("Product in ready!");
        }
        productId += 1;
        products[_barcode] = Product(productId, _name, _price, _stock, _isSell);
        return true;
    }

    function editProduct(
        string memory _barcode,
        string memory _name,
        uint256 _price,
        uint256 _stock,
        bool _isSell
    ) public returns (bool) {
        if (products[_barcode].id == 0) {
            revert("Product not found!");
        }
        productId += 1;
        products[_barcode] = Product(productId, _name, _price, _stock, _isSell);
        return true;
    }

    function sellProduct(string memory _barcode) public returns (bool) {
        Product memory _product = products[_barcode];
        if (_product.isSell == false || _product.stock == 0) {
            revert("Product not sale!");
        }
        _product.stock -= 1;

        products[_barcode] = _product;
        return true;
    }
}
