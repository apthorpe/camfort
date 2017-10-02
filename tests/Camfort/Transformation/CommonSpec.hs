module Camfort.Transformation.CommonSpec (spec) where

import           System.Directory
import           System.FilePath

import           Test.Hspec

import           Camfort.Analysis.Logger (LogLevel (..))
import           Camfort.Functionality

samplesBase :: FilePath
samplesBase = "tests" </> "fixtures" </> "Transformation"

data Example = Example FilePath FilePath

readSample :: FilePath -> IO String
readSample filename = do
  let path = samplesBase </> filename
  readFile path

removeSample filename = do
  let path = samplesBase </> filename
  removeFile path

spec :: Spec
spec =
  describe "Common block integration test" $
    context "common.f90 into common.expect.f90 and foo.f90" $ do
      expected    <- runIO $ readSample "common.expected.f90"
      expectedMod <- runIO $ readSample "cmn.expected.f90"

      let outFile = samplesBase </> "common.f90.out"
          commonFile = samplesBase </> "common.f90"

          env = CamfortEnv
            { ceInputSources = commonFile
            , ceIncludeDir = Just (takeDirectory commonFile)
            , ceExcludeFiles = []
            , ceLogLevel = LogDebug
            }

      runIO $ common outFile env

      actual    <- runIO $ readSample "common.f90.out"
      actualMod <- runIO $ readSample "cmn.f90"
      runIO $ removeSample "common.f90.out"
      runIO $ removeSample "cmn.f90"
      it "it eliminates common statement" $
         actual `shouldBe` expected
      it "it produces a correct module file" $
         actualMod `shouldBe` expectedMod
