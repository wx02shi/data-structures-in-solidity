// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/**
 * @title PriorityQueue
 * @dev A priority queue implemented using a max-heap
 */
contract PriorityQueue {
    struct KVPair {
        uint256 key;
        int256 value;
    }

    struct MaxHeap {
        mapping(uint256 => KVPair) heap;
        uint256 size;
    }

    // Storage

    address owner;
    MaxHeap pq;
    // uint256 public size;

    // Modifiers
    modifier onlyOwner() {
        require(msg.sender == owner, "Sender must be the owner");
        _;
    }

    // Constructor
    constructor() public {
        owner = msg.sender;
    }

    // Internal Functions
    
    /**
     * inserts a new key-value pair
     */
    function insert(uint256 key, int256 value) public onlyOwner {
        pq.heap[pq.size] = KVPair(key, value);
        pq.size++;

        _fixUp(key);
    }

    /**
     * retrieves the highest priority item
     */
    function findMax() public view returns(uint256, int256) {
        return (pq.heap[1].key, pq.heap[1].value);
    }

    /**
     * retrieves the i-th item in the max-heap
     */
    function lookup(uint256 i) public view returns(uint256, int256) {
        return (pq.heap[i].key, pq.heap[i].value);
    }

    /**
     * removes the highest priority item and returns it
     */
    function deleteMax() public onlyOwner returns(uint256, int256) {
        KVPair memory val = pq.heap[1];

        pq.heap[1] = pq.heap[pq.size - 1];
        delete pq.heap[pq.size - 1];
        pq.size--;
        
        _fixDown(1);
        return (val.key, val.value);
    }
    
    // Helper functions

    function _parent(uint256 i) private pure returns(uint256) {
        return (i-1) / 2;
    }

    function _left(uint256 i) private pure returns(uint256) {
        return 2*i + 1;
    }

    function _right(uint256 i) private pure returns(uint256) {
        return 2*i + 2;
    }

    function _fixUp(uint256 i) private {
        uint256 ind = i;
        while (_parent(ind) >= 0 && pq.heap[_parent(ind)].key < pq.heap[ind].key) {
            KVPair memory temp = pq.heap[ind];
            pq.heap[ind] = pq.heap[_parent(ind)];
            pq.heap[_parent(ind)] = temp;

            ind = _parent(ind);
        }
    }

    function _fixDown(uint256 i) private {
        uint256 ind = i;
        while (_left(ind) > pq.size && _right(ind) > pq.size) {
            uint256 j = _left(ind);
            if (_right(ind) <= pq.size && pq.heap[_right(ind)].key > pq.heap[j].key) {
                j = _right(ind);
            }
            if (pq.heap[ind].key >= pq.heap[j].key) {
                break;
            }

            KVPair memory temp = pq.heap[ind];
            pq.heap[ind] = pq.heap[j];
            pq.heap[j] = temp;

            ind = j;
        }
    }
}