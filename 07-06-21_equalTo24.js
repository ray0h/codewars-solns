// https://www.codewars.com/kata/574be65a974b95eaf40008da/train/javascript
// https://www.codewars.com/kata/574e890e296e412a0400149c/train/javascript

// Task

// A game I played when I was young: Draw 4 cards from playing cards, use + - * / and () to make the final results equal to 24.

// You will coding in function equalTo24. Function accept 4 parameters a b c d(4 cards), value range is 1-13.

// The result is a string such as "2*2*2*3" ,(4+2)*(5-1); If it is not possible to calculate the 24, please return "It's not possible!"

// All four cards are to be used, only use three or two cards are incorrect; Use a card twice or more is incorrect too.

// You just need to return one correct solution, don't need to find out all the possibilities.

// Examples

// equalTo24(1,2,3,4) // can return "(1+3)*(2+4)" or "1*2*3*4"
// equalTo24(2,3,4,5) // can return "(5+3-2)*4" or "(3+4+5)*2"
// equalTo24(3,4,5,6) // can return "(3-4+5)*6"
// equalTo24(1,1,1,1) // should return "It's not possible!"
// equalTo24(13,13,13,13) // should return "It's not possible!"

// will not use eval()?
function digitPerm(arr) {
  // let poss = [
  //   [a,b,c,d], [a,b,d,c], [a,c,b,d], [a,c,d,b], [a,d,b,c], [a,d,c,b],
  //   [b,a,c,d], [b,a,d,c], [b,c,a,d], [b,c,d,a], [b,d,a,c], [b,d,c,a],
  //   [c,a,b,d], [c,a,d,b], [c,b,a,d], [c,b,d,a], [c,d,a,b], [c,d,b,a],
  //   [d,a,b,c], [d,a,c,b], [d,b,a,c], [d,b,c,a], [d,c,a,b], [d,c,b,a]
  // ];
  let poss=[]
  arr.forEach((a, ai) => {
    arr.forEach((b, bi) => {
      arr.forEach((c, ci) => {
        arr.forEach((d, di) => {
          if (ai != bi && ai != ci && ai != di && bi != ci && bi != di && ci != di) {
            poss.push([a,b,c,d]);
          };
        });
      });
    });
  });
  var unique = poss.map(cur => JSON.stringify(cur))
    .filter(function(curr, index, self) {
      return self.indexOf(curr) == index;
    })
    .map(cur => JSON.parse(cur))

  return unique;
};

// faster permutation per stack overflow?
// function digitPerm(arr) {
//   var length = arr.length, 
//     result = [arr.slice()];
//     c = new Array(length).fill(0), 
//     i = 1;
//   var k, p;

//   while (i < length) {
//     if (c[i] < i) {
//       k = i % 2 && c[i];
//       p = arr[i];
//       arr[i] = arr[k];
//       arr[k] = p;
//       ++c[i];
//       i = 1;
//       result.push(arr.slice());
//     } else {
//       c[i] = 0;
//       ++i;
//     }
//   }
//   return result;
// }

function operCombo() {
  const ops = ["/", "*", "-", "+"];
  let combos = [];
  for (let i=0; i<4; i++) {
    for (let j=0; j<4; j++) {
      for (let k=0; k<4; k++) {
        combos.push([ops[i], ops[j], ops[k]]);
      };
    };
  };
  return combos;
};

const opers = operCombo();

function equalTo24(a,b,c,d) {
  // const ops = ['/', '*', '-', '+']
  let poss = digitPerm([a,b,c,d]);

  let ans = ""
  for (series of poss) { // each permutation of digits
    if (ans) { break };
    for (ops of opers) {
      if (ans) { break };
      // let expressions = [
        // series[0] + ops[i] + series[1] + ops[j] + series[2] + ops[k] + series[3],
        str = '(' + series[0] + ops[0] + series[1] + ')' + ops[1] + '(' + series[2] + ops[2] + series[3] + ')'
        str2 = series[0] + ops[0] + '(' + series[1] + ops[1] + '(' + series[2] + ops[2] + series[3] + ')' + ')'
        str3 = '(' + '(' + series[0] + ops[0] + series[1] + ')' + ops[1] + series[2] + ')' + ops[2] + series[3]
        if (eval(str) == 24) {
          ans = str;
        } else if (eval(str2) == 24) {
          ans = str2;
        } else if (eval(str3) == 24) {
          ans = str3;
        };
        // series[0] + ops[i] + '(' + series[1] + ops[j] + series[2] + ')' + ops[k] + series[3],
        // series[0] + ops[i] + '(' + series[1] + ops[j] + series[2] + ops[k] + series[3] + ')',
        // series[0] + ops[i] + '(' + '(' + series[1] + ops[j] + series[2] + ')' + ops[k] + series[3] + ')',
        // '(' + series[0] + ops[i] + series[1] + ops[j] + series[2] + ')' + ops[k] + series[3],
        // '(' + series[0] + ops[0] + '(' + series[1] + ops[1] + series[2] + ')' + ')' + ops[2] + series[3]
      // ];
      // for (let x=0; x<3; x++) {
      //   if (eval(expressions[x]) == 24) { 
      //     ans = expressions[x];
      //     x = 5;
      //     break;
      //   };
      // };
    };
  };
  return ans ? ans : "It's not possible!"
};

console.time("benchmark");

// console.log(equalTo24(13,13,13,13));

console.log(equalTo24(1,2,3,4));
console.log(equalTo24(2,3,4,5));
console.log(equalTo24(3,4,5,6));
console.log(equalTo24(1,1,1,1));
console.log(equalTo24(13,13,13,13));
console.log(equalTo24(60,6,12,84));
console.log(equalTo24(5,32,79,39));
console.log(equalTo24(72,96,84,84));
console.log(equalTo24(3,3,8,8));

console.timeEnd("benchmark")

