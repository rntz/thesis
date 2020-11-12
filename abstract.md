The deductive query language Datalog has found a wide array of uses, including
static analysis, business analytics, and distributed programming. Datalog is
attractive because it is high-level and declarative, but simple and well-studied
enough to admit efficient implementation strategies. For example, Whaley and Lam
found they could replace a hand-tuned C implementation of context-sensitive
pointer analysis with a comparably-performing Datalog program that was 100x
smaller [cite:Whaley,aplas05].

However, Datalog's semantics are not stable under extensions. For instance,
simply adding arithmetic operations breaks Datalog's termination guarantee.
Despite this, nearly all practical implementations extend Datalog beyond its
theoretical core to add niceties such as datatypes, arithmetic, aggregations,
and so on. Perhaps most importantly, pure Datalog lacks the facility to
abstract over repeated code: it is easy to express a static analysis over a
*particular* program, but if you wish to express the same analysis over multiple
programs, you must duplicate the analysis code for each program analyzed.

This thesis deconstructs Datalog from a categorical and type theoretic
perspective to determine what makes it tick. Datalog's semantic guarantees are
provided by brute syntactic restrictions, such as stratification and the absence
of function symbols. In place of these, we find compositional semantic
properties such as monotonicity, which we capture using types. We show that
this permits integrating Datalog's features with those of typed functional
languages, such as algebraic data types and higher order functions.

In particular, this thesis makes the following contributions:

1. We define and expound the semantics and metatheory of Datafun, a pure and
total higher-order typed functional language capturing the essence of Datalog.
Where Datalog has predicates defined by a restricted class of Horn clauses,
Datafun has finite sets and set comprehensions; Datalog's bottom-up recursive
queries become iterative fixed points; and Datalog's stratification condition
becomes a matter of tracking monotonicity with types.

2. We show how to generalize seminaive evaluation to handle higher-order
functions. Seminaive evaluation is a technique from the Datalog literature which
improves the performance of Datalog's most distinctive feature: recursive
queries. These are computed iteratively, and under a naive evaluation strategy,
each iteration recomputes all previous values. Seminaive valuation computes a
safe approximation of the difference between iterations. This can asymptotically
improve the performance of Datalog queries. Seminaive evaluation is defined
partly as a program transformation and partly as a modified iteration strategy,
and takes advantage of the first-order nature of Datalog. We extend this
transformation to handle higher-order programs written in Datafun.

TODO: Talk about a theory of monotone change for higher-order languages and how we contribute one of those.
