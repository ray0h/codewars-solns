// https://theconfused.me/blog/solving-the-24-game/

function solve(arr, goal=24, expr=[]) {
  if (expr.length == 0) {
    expr = [...arr]
    // console.log(expr)
  }
  if (arr.length == 1) { 
    return (arr[0] == goal) ? arr[0] : false;
  };
  if (arr.length == 2) {
    let results, resExp
    [results, resExp] = combinetwo(arr[0], arr[1]);
    results.forEach((res, ind) => {
      if (res == goal) {
        return convertToStr(expr[0], expr[1], resExp[ind]);
      };
    });
  };
  let pairs = getComboPairs(arr);
  console.log(pairs)
  pairs.forEach(pair => {
    let possVals, possExprs;
    [possVals, possExprs] = combinetwo(pair[0], pair[1]);
    possVals.forEach((val, ind) => {
      expression = possExprs[ind];
      // console.log(expression)
      aInd = arr.indexOf(pair[0]);
      bInd = arr.indexOf(pair[1]);
      if (aInd = bInd) {
        bInd = arr.indexOf(pair[1], aInd+1);
        // console.log(bInd)
      };
      // console.log(expr)
      let exprString = convertToStr(expr[aInd], expr[bInd], expression);
      let newArr = [...arr];
      let newExpr = [...expr];

      aInd = newArr.indexOf(pair[0]);
      newArr.splice(aInd,1);
      bInd = newArr.indexOf(pair[1]);
      newArr.splice(bInd,1);

      newExpr.splice(aInd,1);
      newExpr.splice(bInd,1);
      newExpr.push(exprString);
      // console.log(newExpr)
      result = solve(newArr, goal, newExpr);
      // console.log(result)
      if (result) {
        return removeRedundBrackets(result);
      } else {
        return;
      }
    })
  })
}

function getComboPairs(arr) {
  let pairs = [];
  arr.forEach((el, ind) => {
    arr.forEach((sec, secInd) => {
      if (ind != secInd) {
        pairs.push([el, sec]);
      };
    });
  });

  var unique = pairs.map(cur => JSON.stringify(cur))
    .filter(function(curr, index, self) {
      return self.indexOf(curr) == index;
    })
    .map(cur => JSON.parse(cur))
  return unique;
};

function convertToStr(a,b,expr) {
  const temp = [a,b];
  // console.log(temp)
  let str = '(' + temp[expr[0]] + ')' + expr[1] + '(' + temp[expr[1]] + ')';
  // console.log(str)
  return str;
};

function combinetwo(a,b) {
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

function removeRedundBrackets(exp) {
  let stack = [];
  let indices = [];
  exp.split('').forEach((ch, ind) => {
    if (ch == '(') {
      stack.push(ind);
    };
    if (ch == ')') {
      let lastBracketInd = stack.pop();
      let enclosed = expr.slice(lastBracketInd+1, ind);
      if (Number(enclosed)) {
        indices.push(i);
        indices.push(lastBracketInd);
      };
    };
  });
  let newExp = [];
  exp.split('').forEach((ch, ind) => {
    if (indices.includes(ind)) {
      newExp.push(ch);
    }
  })
  return newExp,join('');
};

// let res, exp
// [res,exp] = combinetwo(1,2);
// console.log(res)
// console.log(exp)

console.time('benchmark')
console.log(solve([1,2,3,4], 24));
console.timeEnd("benchmark")
