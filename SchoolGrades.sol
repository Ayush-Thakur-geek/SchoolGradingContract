// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SchoolGrades {
    address public teacher;
    mapping(address => uint8) private grades;
    bool private gradingComplete;

    constructor() {
        teacher = msg.sender;
        gradingComplete = false;
    }

    modifier onlyTeacher() {
        require(msg.sender == teacher, "Only the teacher can perform this action");
        _;
    }

    function recordGrade(address student, uint8 grade) public onlyTeacher {
        require(!gradingComplete, "Grading is already complete");
        require(grade <= 100, "Grade must be between 0 and 100");

        grades[student] = grade;
    }

    function finalizeGrading() public onlyTeacher {
        require(!gradingComplete, "Grading is already finalized");
        gradingComplete = true;
    }

    function updateGrade(address student, uint8 newGrade) public onlyTeacher {
        require(!gradingComplete, "Grading is finalized and cannot be changed");
        require(grades[student] != 0, "No grade recorded for the student");
        require(newGrade <= 100, "Grade must be between 0 and 100");

        grades[student] = newGrade;
    }

    function checkGrade(address student) public view returns (uint8) {
        require(grades[student] != 0, "No grade recorded for the student");
        return grades[student];
    }

    function invalidateAllGrades() view public onlyTeacher {
        assert(gradingComplete);
        revert("All grades have been invalidated due to an error");
    }
}
