# SchoolGrades Smart Contract

## Overview

The `SchoolGrades` smart contract is designed to manage a simple grading system in a school environment. It allows a teacher to record, update, finalize, and check students' grades while implementing robust error handling using Solidity's `require()`, `assert()`, and `revert()` statements.

## Features

- **Teacher Ownership**: Only the teacher (contract deployer) can record, update, and finalize grades.
- **Grade Recording**: The teacher can record grades for students, ensuring grades are within a valid range (0-100).
- **Grade Finalization**: Once grading is complete, the teacher can finalize it to prevent further modifications.
- **Grade Checking**: Anyone can check a student's grade once it has been recorded.
- **Error Handling**: The contract includes error handling with `require()`, `assert()`, and `revert()` to ensure data integrity and proper flow of actions.

## Functions

### `recordGrade(address student, uint8 grade)`

Records a grade for a student.

- **Access Control**: Only the teacher can call this function.
- **Parameters**:
  - `student`: The address of the student.
  - `grade`: The grade to be recorded (must be between 0 and 100).
- **Error Handling**:
  - `require(!gradingComplete)`: Ensures grading is not finalized.
  - `require(grade <= 100)`: Ensures the grade is within the valid range.

### `finalizeGrading()`

Finalizes the grading process, preventing any further grade modifications.

- **Access Control**: Only the teacher can call this function.
- **Error Handling**:
  - `require(!gradingComplete)`: Ensures grading hasn't been finalized before.

### `updateGrade(address student, uint8 newGrade)`

Updates the grade for a student, provided grading is not finalized.

- **Access Control**: Only the teacher can call this function.
- **Parameters**:
  - `student`: The address of the student.
  - `newGrade`: The new grade to be recorded (must be between 0 and 100).
- **Error Handling**:
  - `require(!gradingComplete)`: Ensures grading is not finalized.
  - `require(grades[student] != 0)`: Ensures the student has an existing grade.
  - `require(newGrade <= 100)`: Ensures the new grade is within the valid range.

### `checkGrade(address student)`

Checks the grade of a student.

- **Parameters**:
  - `student`: The address of the student.
- **Returns**: The grade of the student (if recorded).
- **Error Handling**:
  - `require(grades[student] != 0)`: Ensures the student has an existing grade.

### `invalidateAllGrades()`

Invalidates all recorded grades, typically used in the case of a major error.

- **Access Control**: Only the teacher can call this function.
- **Error Handling**:
  - `assert(gradingComplete)`: Ensures grading is finalized before invalidation.
  - `revert()`: Cancels the function execution with an error message indicating grades have been invalidated.

## Usage

1. **Deployment**: Deploy the contract to the Ethereum network or any EVM-compatible blockchain. The deploying address becomes the `teacher`.
2. **Record Grades**: The teacher can use the `recordGrade()` function to record grades for students.
3. **Check Grades**: Anyone can check a student's grade using the `checkGrade()` function.
4. **Update Grades**: Before finalization, the teacher can update grades using the `updateGrade()` function.
5. **Finalize Grading**: Once all grades are recorded, the teacher can finalize the grading process using the `finalizeGrading()` function.
6. **Invalidate Grades**: If needed, the teacher can invalidate all grades using the `invalidateAllGrades()` function.

## Error Handling

The contract includes multiple layers of error handling:

- **`require()`**: Used to enforce preconditions before executing a function, such as ensuring the caller is the teacher or that the grade is within a valid range.
- **`assert()`**: Used to validate internal state, such as ensuring grading is complete before allowing grade invalidation.
- **`revert()`**: Explicitly reverts the transaction if an error occurs, providing a meaningful error message.

## License

This project is licensed under the MIT License.
