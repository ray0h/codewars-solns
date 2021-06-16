// https://www.codewars.com/kata/566584e3309db1b17d000027/train/javascript

// Create a function that differentiates a polynomial for a given value of x.

// Your function will receive 2 arguments: a polynomial as a string, and a point to evaluate the equation as an integer.

// Assumptions:

// There will be a coefficient near each x, unless the coefficient equals 1 or -1.
// There will be an exponent near each x, unless the exponent equals 0 or 1.
// All exponents will be greater or equal to zero
// Examples:

// differenatiate("12x+2", 3)      ==>   returns 12
// differenatiate("x^2+3x+2", 3)   ==>   returns 9



function differentiate(equation, point) {
  function diffMonomial(mono, point) {
    // digits
    if (/^-?[0-9]*$/.test(mono)) {
      return 0; 
    // x^1
    } else if (/x(?!.)/.test(mono)) {
      return mono == 'x' ? 1 : mono == '-x' ? -1 : parseInt(mono);
    // x^n
    } else {
      let pair = mono.split('x^').map(s => s == '' ? 1 : s == '-' ? -1 : parseInt(s));
      return (pair[0]*pair[1]) * point**(pair[1]-1)
    }
  };

  // get monomials from equation string
  let monomials = equation.match(/-?\d*x\^?\d+?|-?\d*?x|-?\d+/g);
  
  // differentiate/evaluate each subSegment, reduce to sum
  return monomials.map(sub => diffMonomial(sub, point)).reduce((a,b) => a+b );
};

console.log(differentiate('x^2-66', 3))
