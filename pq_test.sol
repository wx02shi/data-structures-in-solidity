// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../../src/PriorityQueues/Heap.sol";

contract HeapTest is Test {
    Heap public heap;

    function setUp() public {
        heap = new Heap(9);
    }

    function testInsert() public {
        heap.insert(50);
        heap.insert(10);
        heap.insert(29);
        heap.insert(26);
        heap.insert(27);
        heap.insert(15);
        heap.insert(8);
        heap.insert(34);
        heap.insert(23);

        assertEq(heap.arr(0), 50);
        assertEq(heap.arr(1), 34);
        assertEq(heap.arr(2), 29);
        assertEq(heap.arr(3), 27);
        assertEq(heap.arr(4), 26);
        assertEq(heap.arr(5), 15);
        assertEq(heap.arr(6), 8);
        assertEq(heap.arr(7), 10);
        assertEq(heap.arr(8), 23);
    }

    function testFindMax() public {
        heap.insert(50);
        heap.insert(10);
        assertEq(heap.findMax(), 50);
    }

    function testDeleteMax() public {
        heap.insert(50);
        heap.insert(10);
        heap.insert(29);
        heap.insert(26);
        heap.insert(27);
        heap.insert(15);
        heap.insert(8);
        heap.insert(34);
        heap.insert(23);

        heap.deleteMax();

        assertEq(heap.arr(0), 34);
        assertEq(heap.arr(1), 27);
        assertEq(heap.arr(2), 29);
        assertEq(heap.arr(3), 23);
        assertEq(heap.arr(4), 26);
        assertEq(heap.arr(5), 15);
        assertEq(heap.arr(6), 8);
        assertEq(heap.arr(7), 10);
    }
}