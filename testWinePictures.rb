require 'test/unit'
require 'WinePictures'
require 'FileNameUtils.rb' 

module TestWinePictures
  
  class TestIsNewBottle < Test::Unit::TestCase
    def testIsNewBottle 
      wf = WinePictures::WineFile.new()
      result = wf.isNewBottle("Bottle")
      assert_equal result, true
      result = wf.isNewBottle("Bottle")
      assert_equal result, false
      result = wf.isNewBottle("Bottle2")
      assert_equal result, true
    end
  end
  
  class TestIsLabelPresent < Test::Unit::TestCase
    
    def testisLabelPresent
      fnu = FileNameUtils::FileNameUtils.new()
      result = fnu.isLabelPresent("Unit_Test.*")
      assert_equal result, true
      result = fnu.isLabelPresent("Unit_Test_false.*")
      assert_equal result, false
    end
  end
  
  class TestBottleName < Test::Unit::TestCase
    def testBottleName
      tbn = WinePictures::BottleName.new("Unit Test")
      result = tbn.searchName
      assert_equal result, "Unit Test"
      result = tbn.fileRoot
      assert_equal result, "Unit_Test"
      result = tbn.fileName("jpg")
      assert_equal result, "Unit_Test.jpg"  
    end
  end
 
  
end