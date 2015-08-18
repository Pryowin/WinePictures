require 'test/unit'
require 'WinePictures'


module TestWinePictures
  
  class TestIsNewBottle < Test::Unit::TestCase
    def testIsNewBottle 
      wf = WinePictures::WineFile.new()
      result = wf.isNewBottle(WinePictures::BottleName.new("Bottle"))
      assert_equal result, true
      result = wf.isNewBottle(WinePictures::BottleName.new("Bottle"))
      assert_equal result, false 
      result = wf.isNewBottle(WinePictures::BottleName.new("Bottle2"))
      assert_equal result, true
      result = wf.isNewBottle(WinePictures::BottleName.new("Unit_Test"))
      assert_equal result, false
    end
  end
  
  class TestIsLabelPresent < Test::Unit::TestCase
    
    def testisLabelPresent
      fnu =  WinePictures::FileNameUtil.new()
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
      result = tbn.fileName(".jpg")
      assert_equal result, "Unit_Test.jpg"  
    end
  end
  
  class TestBottleNameApostrophe < Test::Unit::TestCase
      def testBottleName
        tbn = WinePictures::BottleName.new("Lover's")
        result = tbn.searchName
        assert_equal result, "Lovers"
      end
  end
  
  class TestSetUri < Test::Unit::TestCase
    def testSetUri
      tbn = WinePictures::BottleName.new("Castle Rock Syrah label")
      tbn.setUri
      result = tbn.uri
      assert_equal result, "http://sr1.wine-searcher.net/images/labels/92/68/10249268.jpg"
    end
  end
  
end