-- suppose we want to make (,) r an applicative functor
-- that means we need to implement
-- r could be any type, for representing labels
-- but now we have two pieces of data containing labels (i.e., (r,a->b) and (r,a))

-- 1. how should we implement (<*>) so that the resulting data contain appropriate label?
-- ANS --
--      We should combine both labels together. 
--      For example, if they are strings, we should concatenate them. If they are integers, we should sum them. If they are set, we should union them.

-- Try to implement 
-- (Aj. Chin said that it is a thought experiment, and there's no need to write the code perfectly. 
--   This code is just an idea and does not cover all cases.)
(<*>) :: (r, a -> b) -> (r, a) -> (r, b)
(fl, f) <*> (xl, x) = (combL fl xl, f x)
    where combL fl xl = fl ++ xl -- for string
--  where combL fl xl = fl + xl --for integers


-- 2. how should we implement pure so that the initial label makes sense?
--      For String, use an empty string "".
--      For numbers, use 0 (or 1 if it represents a multiplier).
--      For lists, use the empty list [].
--      For sets, use the empty set.
-- example
pure :: a -> (r, a)
pure x = ("", x)


-- 3. prove that the four applicative functor laws hold for (->) r applicative functor
-- Applicative laws

-- Identity  pure id <*> v = v
--  (pure id <*> v) x
--      = (const id <*> v) x
--      = (const id x (v x))
--      = id (v x)
--      = v x
-- pure id <*> v = v TRUE

-- Composition  pure (.) <*> u <*> v <*> w = u <*> (v <*> w)
--  ((pure (.)) <*> u <*> v <*> w) x
--      = ((const (.) <*> u <*> v <*> w) x)
--      = ((const (.) x (u x)) (v x) (w x))
--      = ((u x . v x) (w x))
--      = (u x (v x (w x)))
--  (u <*> (v <*> w)) x
--      = (u x ((v <*> w) x))
--      = (u x (v x (w x)))
-- pure (.) <*> u <*> v <*> w = u <*> (v <*> w) TRUE


-- Homomorphism  pure f <*> pure x = pure (f x)
--  (pure f <*> pure x) r
--      = ((const f <*> const x) r)
--      = const f r (const x r)
--      = f (x)
-- pure f <*> pure x = pure (f x) TRUE

-- Interchange u <*> pure y = pure ($ y) <*> u
--  (u <*> pure y) x
--      = (u x (const y x))
--      = u x y
--  (pure ($ y) <*> u) x
--      = (const ($ y) x (u x))
--      = ($ y) (u x)
--      = u x y
-- u <*> pure y = pure ($ y) <*> u TRUE