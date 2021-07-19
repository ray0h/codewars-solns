// based on fairly intuitive recursive solution - https://theconfused.me/blog/solving-the-24-game/
// rather than evaluating each possible four part expression, this data structure involves a pair of arrays - one with possible pairs of expressions and /// the other with their corresponding values.  
// The algorithm creates all possible pairs of numbers from the initial array, evaluates all possible expressions involving those pairs and recursively iterating through until goal is // 
// reached.  If no valid expression is found, it returns "It's not possible"

function solve(arr, goal=24, expr=[]) {
  if (expr.length == 0) { expr = [...arr] };

  if (arr.length == 1) { return (arr[0] == goal) ? arr[0] : false };

  if (arr.length == 2) {
    let results, resExp, answer = false;
    [results, resExp] = combineTwo(arr[0], arr[1]);
    results.forEach((res, ind) => {
      // stupid javascript fraction / repeating decimal issues...
      let rounded = Math.abs(res*10000 - 240000)
      if (rounded < 1) { answer = convertToStr(expr[0], expr[1], resExp[ind]) };
    });
    return answer;
  };

  let pairs = getComboPairs(arr);
  let result = ''
  for (let i=0; i<pairs.length; i++) {
    let pair = pairs[i];
    let possVals, possExprs;
    [possVals, possExprs] = combineTwo(pair[0], pair[1]);

    for (let j=0; j<possVals.length; j++) {
      let val = possVals[j];
      let exprn = possExprs[j];
      let aInd = arr.indexOf(pair[0]);
      let bInd = arr.indexOf(pair[1]);
      if (aInd == bInd) { bInd = arr.indexOf(pair[1], aInd+1) };

      let exprStr = convertToStr(expr[aInd], expr[bInd], exprn);
      let newArr = [...arr];
      let newExpr = [...expr];

      aInd = newArr.indexOf(pair[0]);
      newArr.splice(aInd,1);
      bInd = newArr.indexOf(pair[1]);
      newArr.splice(bInd,1);
      newArr.push(val);

      newExpr.splice(aInd,1);
      newExpr.splice(bInd,1);
      newExpr.push(exprStr);
      result = solve(newArr, goal, newExpr);
      if (result) { return removeRedundBrackets(result) }; 
    }
  }
  if (!result && arr.length == 4) { return "It's not possible!"}
}

function getComboPairs(arr) {
  let pairs = [];
  
  arr.forEach((el, ind) => {
    arr.forEach((sec, secInd) => {
      if (ind != secInd) { pairs.push([el, sec]) };
    });
  });

  var unique = pairs.map(cur => JSON.stringify(cur))
    .filter(function(curr, index, self) {
      return self.indexOf(curr) == index;
    })
    .map(cur => JSON.parse(cur));
  return unique;
};

function convertToStr(a,b,expr) {
  const temp = [a,b];
  let str = '(' + temp[expr[0]] + ')' + expr[1] + '(' + temp[expr[2]] + ')';
  return str;
};

function combineTwo(a,b) {
  let results = [a+b, a*b];
  let exp = [[0,'+',1], [0,'*',1]];
  if (b > a) {
    results.push(b-a);
    exp.push([1,'-',0]);
  } else {
    results.push(a-b);
    exp.push([0,'-',1]);
  };
  if (b != 0) {
    results.push(a/b);
    exp.push([0,'/',1]);
  };
  if (a != 0) {
    results.push(b/a);
    exp.push([1,'/',0]);
  };
  return [results, exp];
};

function removeRedundBrackets(expr) {
  let stack = [];
  let indices = [];

  expr.split('').forEach((ch, ind) => {
    if (ch == '(') { stack.push(ind) };
    if (ch == ')') {
      let lastBracketInd = stack.pop();
      let enclosed = expr.slice(lastBracketInd+1, ind);
      if (Number(enclosed)) {
        indices.push(ind);
        indices.push(lastBracketInd);
      };
    };
  });
  let newExp = [];
  expr.split('').forEach((ch, ind) => {
    if (!indices.includes(ind)) { newExp.push(ch) };
  })
  return newExp.join('');
};

function equalTo24(a,b,c,d) {
  return solve([a,b,c,d]);
};

console.time("benchmark");

console.log(solve([1,2,3,4]));
console.log(solve([2,3,4,5]));
console.log(solve([3,4,5,6]));
console.log(solve([1,1,1,1]));
console.log(solve([13,13,13,13]));
console.log(solve([60,6,12,84]));
console.log(solve([5,32,79,39]));
console.log(solve([72,96,84,84]));
console.log(solve([3,3,8,8]));
console.log(solve([72,4,3,1]));
console.log(solve([1,4,60,72]));
console.log(solve([4,20,60,72]));

console.timeEnd("benchmark")