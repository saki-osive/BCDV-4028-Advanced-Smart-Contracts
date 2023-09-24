// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// ArrayUtils is a custom implementation of a library that aims to
// implement 2 custom methods on Arrays, 1 to sort the elements of an array
// & 2 to remove duplicate elements from an array
library ArrayUtils {
    // In this function, we use the Bubble Sort technique to sort the elements in the array.
    function bubbleSort(uint[] memory arr) internal pure returns (uint[] memory) {
        uint len = arr.length;
        for (uint i = 0; i < len - 1; i++) {
            for (uint j = 0; j < len - i - 1; j++) {
                if (arr[j] > arr[j + 1]) {
                    (arr[j], arr[j + 1]) = (arr[j + 1], arr[j]);
                }
            }
        }
        return arr;
    }

    // In this function, we aim to remove duplicates from an array by comparing
    // them using for loop
    function removeDuplicates(uint[] memory arr) internal pure returns (uint[] memory) {
        if (arr.length <= 1) {
            return arr;
        }

        uint[] memory uniqueArr = new uint[](arr.length);
        uint uniqueCount = 0;

        for (uint i = 0; i < arr.length; i++) {
            bool isDuplicate = false;
            for (uint j = 0; j < uniqueCount; j++) {
                if (arr[i] == uniqueArr[j]) {
                    isDuplicate = true;
                    break;
                }
            }
            if (!isDuplicate) {
                uniqueArr[uniqueCount] = arr[i];
                uniqueCount++;
            }
        }

        uint[] memory result = new uint[](uniqueCount);
        for (uint i = 0; i < uniqueCount; i++) {
            result[i] = uniqueArr[i];
        }

        return result;
    }
}

// Here we create a contract to use the library functions that we defined
// earlier.
contract ArrayManipulation {
    using ArrayUtils for uint[];

    uint[] private data;

    function setData(uint[] memory _data) external {
        data = _data;
    }

    function sortData() external view returns (uint[] memory) {
        return data.bubbleSort();
    }

    function removeDuplicates() external view returns (uint[] memory) {
        return data.removeDuplicates();
    }
}
