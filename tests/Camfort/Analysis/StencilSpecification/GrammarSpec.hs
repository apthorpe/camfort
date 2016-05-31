module Camfort.Analysis.StencilSpecification.GrammarSpec (spec) where

import Camfort.Analysis.StencilSpecification.Grammar

import Test.Hspec hiding (Spec)
import qualified Test.Hspec as Test

spec :: Test.Spec
spec =
  describe "Stencils - Grammar" $ do
    it "basic stencil" $
      parse "stencil atLeast, reflexive(dims=1,2), \
             \       forward(depth=1, dim=1) :: x"
      `shouldBe`
        Just (SpecDec (Spatial [AtLeast,Reflexive [1,2]] (Forward 1 1)) ["x"])

    it "basic stencil with reflexive and irreflexive" $
      parse "stencil atLeast, reflexive(dims=2),  \
            \        irreflexive(dims=1), forward(depth=1, dim=1) :: frob"
      `shouldBe`
        Just (SpecDec (Spatial [AtLeast, Irreflexive [1], Reflexive [2]]
                               (Forward 1 1)) ["frob"])

    it "region defn" $
      parse "region r = forward(depth=1, dim=1) + backward(depth=2, dim=2)"
      `shouldBe`
        Just (RegionDec "r" (Or (Forward 1 1) (Backward 2 2)))

    it "temporal" $
      parse "stencil dependency(a,b,c,foo), mutual :: foo, bar"
      `shouldBe`
       Just (SpecDec (Temporal ["a","b","c","foo"] True) ["foo", "bar"])

    it "complex stencil" $
      parse "stencil atLeast, reflexive(dims=1,2), readOnce, \
            \ (forward(depth=1, dim=1) + r) * backward(depth=3, dim=4) \
            \ :: frob"
      `shouldBe`
       Just (SpecDec (Spatial [AtLeast,ReadOnce,Reflexive [1,2]]
             (And (Or (Forward 1 1) (Var "r")) (Backward 3 4))) ["frob"])

parse = specParser

-- Local variables:
-- mode: haskell
-- haskell-program-name: "cabal repl test-suite:spec"
-- End:
