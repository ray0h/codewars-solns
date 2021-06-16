// https://www.codewars.com/kata/5679d5a3f2272011d700000d/train/javascript

// codewars JS doesn't recognize Array.prototype.flat()
function flatten(arr, toFlatten) {
  if (toFlatten > 1) {
    arr = flatten(arr, toFlatten - 1);
  }
  let flattened = arr.reduce((acc, curVal) => { return acc.concat(curVal)}, []);
  return flattened;
};

// set up initial guess grida
function initialGrid() {
  return Array.from({length:6}, (_, i) => Array.from({length:6}, (_, j) => 0));
};

// is grid matrix solved?
function gridSolved(grid) {
  return flatten(grid, 2).length === 36;
};

function findFilterUniques(line) {
  // find unique value in a line
  let vals = [1, 2, 3, 4, 5, 6];
  let uniques = vals.filter(no => flatten(line, 2).filter(x => x === no).length === 1);
  line = line.map(spot => spot.filter(no => uniques.includes(no)).length === 1 ? spot.filter(no => uniques.includes(no)) : spot);
  // eliminate unique values from possible spots in a line
  uniques = flatten(line.filter(no => no.length === 1), 1);
  return line.map(spot => spot.length === 1 ? spot : spot.filter(no => !uniques.includes(no)));
};

// get row line
function getRow(rowVal, grid, flip) {
  let row = flip ? grid[rowVal].reverse() : grid[rowVal];
  return row;
};

// replace row
function replaceRow(rowVal, row, grid, flip) {
  row = flip ? row.reverse() : row;
  grid[rowVal] = row;
  return grid;
};

// get column
function getCol(colVal, grid, flip) {
  let col = flip ? grid.map((_spot, ind) => grid[grid.length-1 - ind][colVal]) : grid.map((_spot, ind) => grid[ind][colVal]);
  return col;
};

// replace column
function replaceCol(colVal, col, grid, flip) {
  col = flip ? col.reverse() : col;
  grid.forEach((_spot, ind) => grid[ind][colVal] = col[ind] );
  return grid;
};

function bldgCount(line) {
  let count = 1;
  let tallest = flatten(line[0], 1);
  for (let i=1; i<line.length; i++) {
    if (flatten(line[i], 1) > tallest) {
      tallest = flatten(line[i], 1);
      count++;
    };
  };
  return count;
};

function findPossibles(line) {
  let length = line.length;
  let indices = new Array(length).fill(0)
  let possibles = [];
  let tempArr = [];

  while (true) {
    for (let i=0; i<length; i++) { tempArr.push([line[i][indices[i]]]) };
    possibles.push(tempArr);
    tempArr = [];

    let next = length - 1;
    while (next >= 0 && indices[next] + 1 >= line[next].length) { next-=1 };

    if (next < 0) { break };

    indices[next] += 1;

    for (let i=next+1; i<length; i++) { indices[i] = 0 };
  }
  // only return unique arrays
  return possibles.filter(x => [...new Set(flatten(x, 1))].length === x.length);
};

function getSpots(index, array) {
  return [...new Set(flatten(array.map(sub => sub[index]), 1))].map(val => [val]);
};

function clueSection(grid, clues, cluedArray, no, offset, getFn, replFn, flip) {
  let line = getFn(no+offset, grid, flip);
  let clueLine = cluedArray[clues[no]];
  line = line.map((_val, ind) => line[ind].length > clueLine[ind].length ? clueLine[ind] : line[ind]);
  grid = replFn(no+offset, line, grid, flip);
};

function applyClues(grid, clues) {
  const cluedArray = [
    [[1,2,3,4,5,6], [1,2,3,4,5,6], [1,2,3,4,5,6], [1,2,3,4,5,6], [1,2,3,4,5,6], [1,2,3,4,5,6]],
    [[6], [1,2,3,4,5], [1,2,3,4,5], [1,2,3,4,5], [1,2,3,4,5], [1,2,3,4,5]],
    [[1,2,3,4,5], [1,2,3,4,5,6], [1,2,3,4,5,6], [1,2,3,4,5,6], [1,2,3,4,5,6], [1,2,3,4,5,6]],
    [[1,2,3,4], [1,2,3,4,5], [1,2,3,4,5,6], [1,2,3,4,5,6], [1,2,3,4,5,6], [1,2,3,4,5,6]],
    [[1,2,3], [1,2,3,4], [1,2,3,4,5], [1,2,3,4,5,6], [1,2,3,4,5,6], [1,2,3,4,5,6]],
    [[1,2], [1,2,3], [1,2,3,4], [1,2,3,4,5], [1,2,3,4,5,6], [1,2,3,4,5,6]],
    [[1], [2], [3], [4], [5], [6]]
  ];
  // top -> bot columns
  [0, 1, 2, 3, 4, 5].forEach(function(no) { 
    grid = replaceCol(no, cluedArray[clues[no]], grid)
  });
  // right -> left rows
  [6, 7, 8, 9, 10, 11].forEach(no => clueSection(grid, clues, cluedArray, no, -6, getRow, replaceRow, true));
  // bot -> top columns
  [12, 13, 14, 15, 16, 17].forEach((no, ind) => clueSection(grid, clues, cluedArray, no, -(7+2*ind), getCol, replaceCol, true));
  // left -> right rows
  [18, 19, 20, 21, 22, 23].forEach((no, ind) => clueSection(grid, clues, cluedArray, no, -(13+2*ind), getRow, replaceRow, false));

  return grid;
};

function iterSection(no, offset, grid, clues, getFn, replFn, flip) {
  let line = getFn(no+offset, grid, flip);
  if (clues[no] !== 0) {
    let possibles = findPossibles(line).filter(x => bldgCount(x) === clues[no]);
    line = line.map((sub, ind) => sub.filter(no => flatten(getSpots(ind, possibles), 1).includes(no)));
  };
  line = findFilterUniques(line);
  grid = replFn(no+offset, line, grid, flip);
};

function iterate(grid, clues) {
  // top -> bot columns
  [0, 1, 2, 3, 4, 5].forEach(no => iterSection(no, 0, grid, clues, getCol, replaceCol, false));
  // left -> right rows
  [6, 7, 8, 9, 10, 11].forEach(no => iterSection(no, -6, grid, clues, getRow, replaceRow, true));
  // bot -> top columns
  [12, 13, 14, 15, 16, 17].forEach((no, ind) => iterSection(no, -(7+2*ind), grid, clues, getCol, replaceCol, true));
  // left -> right rows
  [18, 19, 20, 21, 22, 23].forEach((no, ind) => iterSection(no, -(13+2*ind), grid, clues, getRow, replaceRow, false));

  return grid;
};

// driver
console.time('Execution Time');
let grid = initialGrid();
// let clues = [3, 2, 2, 3, 2, 1, 1, 2, 3, 3, 2, 2, 5, 1, 2, 2, 4, 3, 3, 2, 1, 2, 2, 4]
// let clues = [0, 0, 0, 2, 2, 0, 0, 0, 0, 6, 3, 0, 0, 4, 0, 0, 0, 0, 4, 4, 0, 3, 0, 0]
let clues = [0, 3, 0, 5, 3, 4, 0, 0, 0, 0, 0, 1, 0, 3, 0, 3, 2, 3, 3, 2, 0, 3, 1, 0]
grid = applyClues(grid, clues);
while (!gridSolved(grid)) {
  grid = iterate(grid, clues);
};
// console.log(grid)
console.log(grid.map(row => flatten(row, 1)));

console.timeEnd('Execution Time');
