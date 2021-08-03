// https://www.codewars.com/kata/551f23362ff852e2ab000037/train/javascript
// Lyrics...

// Pyramids are amazing! Both in architectural and mathematical sense. If you have a computer, you can mess with pyramids even if you are not in Egypt at the time. For example, let's consider the following problem. Imagine that you have a pyramid built of numbers, like this one here:

//    /3/
//   \7\ 4 
//  2 \4\ 6 
// 8 5 \9\ 3
// Here comes the task...

// Let's say that the 'slide down' is the maximum sum of consecutive numbers from the top to the bottom of the pyramid. As you can see, the longest 'slide down' is 3 + 7 + 4 + 9 = 23

// Your task is to write a function longestSlideDown (in ruby/crystal/julia: longest_slide_down) that takes a pyramid representation as argument and returns its' largest 'slide down'. For example,

// longestSlideDown([[3], [7, 4], [2, 4, 6], [8, 5, 9, 3]]) => 23
// By the way...

// My tests include some extraordinarily high pyramids so as you can guess, brute-force method is a bad idea unless you have a few centuries to waste. You must come up with something more clever than that.

// (c) This task is a lyrical version of the Problem 18 and/or Problem 67 on ProjectEuler.

// Good practice reviewing recursive functions...
// Good practice thinking again about trees.
// Initial thoughts looked at Pascal Triangles and coefficients (interesting, but pointless tangent...)
// Even though it said not to, took a brute force path trying to figure out ALL possible sums, but the number of possible sums is 2^pyramid_length-1
// so this leads to far too many calculations really quickly.

// then looking at it one last time several days later, the successful algorithm looks at the bottom two rows, finds the max 


function longestSlideDown(pyramid) {
  if (pyramid.length == 1) {
    console.log(pyramid)
    return pyramid[0][0];
  } else {
    let sumArr = [];
    let penultRow = [...pyramid[pyramid.length-2]];
    let lastRow = [...pyramid[pyramid.length-1]];

    penultRow.forEach((el, ind) => {
      let firstSum = el + lastRow[ind];
      let secondSum = el + lastRow[ind+1];
      firstSum > secondSum ? sumArr.push(firstSum) : sumArr.push(secondSum); 
    });

    pyramid.pop();
    pyramid[pyramid.length-1] = sumArr;
    longestSlideDown(pyramid);
  };

  return pyramid[0][0];
};

console.time("benchmark");

console.log(longestSlideDown([[3],
  [7, 4],
  [2, 4, 6],
  [8, 5, 9, 3]]));
console.log(longestSlideDown([[81]]))
console.timeEnd("benchmark");