## Notes

* Haskell defines data dependencies vs statements being evaluated one at a time like most languages -> the reason Monads exists was to model IO as data dependencies
* Haskell had to choose: lazy vs strict. Johan Tibell? said it's the wrong questions: Haskell has functions and data - should have been strict data and lazy functions
* When you're writing a library be as general as possible. When you're writing an application, be as monomorphic as possible. As a rule of thumb - not always
* 


## Mentions

* http://blog.ezyang.com/2011/04/the-haskell-heap/
* http://blog.johantibell.com/


## Questions

* part1 / part2 / answer example is confusing (https://github.com/fpco/applied-haskell/blob/2018/all-about-strictness.md#bang)
* How do bangs on data types de-sugar? 
  * It's not sugar, it's part of the syntax
* What are the costs of turning on optimizations? Why not have them on by default? 
  * Optimizations are turned when running builds with cabal files
* What is C--?
  * https://en.wikipedia.org/wiki/C--
