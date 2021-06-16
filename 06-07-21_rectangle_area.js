// https://www.codewars.com/kata/55dcdd2c5a73bdddcb000044/train/javascript

// Your task in order to complete this Kata is to write a function which calculates the area covered by a union of rectangles.
// Rectangles can have non-empty intersection, in this way simple solution: Sall = S1 + S2 + ... + Sn-1 + Sn (where n - the quantity of rectangles) will not work.

// Preconditions

// each rectangle is represented as: [x0, y0, x1, y1]
// (x0, y0) - coordinates of the bottom left corner
// (x1, y1) - coordinates of the top right corner
// xi, yi - positive integers or zeroes (0, 1, 2, 3, 4..)
// sides of rectangles are parallel to coordinate axes
// your input data is array of rectangles
// Memory requirements

// Number of rectangles in one test (not including simple tests) range from 3000 to 15000. There are 10 tests with such range. So, your algorithm should be optimal.

// Tried several methods (all of which generally worked, but were not optimized):
// 1. Sum areas of each rectangles, determine which rectangles overlapped and substract overlapping areas
// 2. Create hash/dictionary of rectangle space, iterate through each rectangle, adding area points to hash object (overlaps can be counted as much as you want..)
// 3. Naive approach to sweep line algorithm, but took too long when rectangles spaced far apart

// finally had to research different variations of binary search tree's which could potentially be used (treaps, interval trees = segment trees?) and came across an algorithm which used a segment tree with the sweep line algorithm.
// the segment tree was comprised of all possible x intervals.
// sweeping across the rectangles were treated as an array of events with entering/exiting a rectangle space dictated by an OFFSET variable
// a 'counter' and 'score' (total length) array/tree was established and a change function would update the two arrays.  Based on the counter values, the score array would reflect the tree nodes and the current length of the 'union of intervals'.
// going through it, the algorithm(s) makes sense and I learned a good bit about additional value/applications for BST's, but it was a bit disheartening since not sure if I could have put this together myself...
// 'a-ha!' algorithm page: https://tryalgo.org/en/geometry/2016/06/25/union-of-rectangles/

class IntervalTree {
  constructor(intervals) {
    this.intervals = intervals
    this.N = 1;
    while (this.N < this.intervals.length) { this.N *= 2 }
    this.covered = new Array(2 * this.N).fill(0); // -- counter of rectangles/intervals included in sweep line
    this.score = new Array(2 * this.N).fill(0); // -- 'tree' of covered intervals (counter * segment tree)
    this.tree = new Array(2 * this.N).fill(0); // -- segment tree of intervals

    // generate segment tree of intervals - note this algorithm creates root at index 1.
    this.intervals.forEach((int, ind) => this.tree[this.N + ind] = this.intervals[ind]);
    for (let i = this.N - 1; i > 0; --i) { this.tree[i] = this.tree[2*i] + this.tree[2*i+1]}
  };

  // returns total length of intervals (union)
  length() {
    return this.score[1];
  };

  // i, k are points of new interval; offset is open/close; when offset is +1, interval is added; when offset is -1, interval is removed.
  change(i,k,offset) {
    this._change(1, 0, this.N, i, k, offset);
  };

  // recursive function to updated covered counter and corresponding score
  _change(node, start, span, i, k, offset) {
    if (start + span <= i || k <= start) { return }; // disjointed - shouldn't happen?

    if (i <= start && start + span <= k) { 
      // found interval node
      this.covered[node] += offset;
    } else {
      // keep searching for node
      this._change(2*node, start, Math.floor(span/2), i, k, offset); // left branch
      this._change(2*node+1, start+Math.floor(span/2), Math.floor(span/2), i, k, offset); // right branch
    };

    if (this.covered[node] == 0) {
      this.score[node] = (node >= this.N) ? 0 : this.score[2*node] + this.score[2*node+1];
    } else {
      this.score[node] = this.tree[node];
    }; 
  };
};

function calculate(recs) {
  const ADDING = +1;
  const REMOVING = -1;
  if (recs.length == 0) { return 0 };
  let xs = [];
  let events = [];
  recs.forEach(function(rec) {
    [x1, y1, x2, y2] = rec;  // deconstruction for the win...
    // create array of unique x's for intervals
    if (xs.indexOf(x1) == -1) { xs.push(x1) };
    if (xs.indexOf(x2) == -1) { xs.push(x2) };
    // fill events array with y start/end points and corresponding offsets
    events.push([y1, ADDING, x1, x2]);
    events.push([y2, REMOVING, x1, x2]);
  });
  i_to_x = xs.sort((a,b) => a-b);
  let x_to_i = {}; // hash of x points mapping its index
  i_to_x.forEach((el, ind) => x_to_i[i_to_x[ind]] = ind);
  x_intervals = [];
  for (let i=0; i<i_to_x.length - 1; i++) {
    x_intervals.push(i_to_x[i + 1] - i_to_x[i])
  };
  
  let IT = new IntervalTree(x_intervals);
  let area = 0;
  let prev_y = 0;
  // sweep line across y's (but only y's in all rectangles)
  events.sort((a,b)=>a[0]-b[0]).forEach(function(event) {
    [y, offset, x1, x2] = event;
    area += (y - prev_y) * IT.length();
    i1 = x_to_i[x1];
    i2 = x_to_i[x2];
    IT.change(i1, i2, offset);
    prev_y = y;
  });
  return area;
}

console.log(calculate([[0,0,1,1], [0,0,2,2]]));
console.log(calculate([[3,3,8,5], [6,3,8,9], [11,6,14,12]]))
console.log(calculate([[3,3,8,5], [11,6,14,12], [6,3,8,9]]))

console.log(calculate([[ 1, 1, 2, 2 ],
  [ 1, 4, 2, 7 ],
  [ 1, 4, 2, 6 ],
  [ 1, 4, 4, 5 ],
  [ 2, 5, 6, 7 ],
  [ 4, 3, 7, 6 ]]))