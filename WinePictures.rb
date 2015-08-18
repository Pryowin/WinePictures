require 'google-search'
require 'csv.rb'
require 'FileNameUtils.rb' 

module WinePictures
  
  class WineFile
    
    PATH_NAME = "D:/Users/David/Workspace/WinePictures/"
    FILE_NAME = "export-bottles-stored.csv"
   
    @lastBottle = String.new()
    @fnu = FileNameUtils::FileNameUtils.new()
    
    def readFile
      fqn = PATH_NAME + FILE_NAME
      i=0
      bottleDesc = Array.new()
      
      CSV.foreach(fqn,  encoding: "bom|UTF-8", :row_sep => :auto, :headers => true) do |bottle|   
          bottleDesc[i] = "#{bottle['Winery']} #{bottle['Name']} label"
          i += 1
      end
     return bottleDesc
    end
    
    def isNewBottle(bottle)
      if bottle == @lastBottle
           return false
      end
      @lastBottle = bottle   
      return true
    end
  end
  
  class BottleName
    
    def initialize(name)
      @searchName = name
      @fileRoot = name.to_s.gsub(" ","_")
    end
    
    def searchName
      return @searchName
    end
    
    def fileRoot
      return @fileRoot
    end
      
    def fileName (ext)
      return fileRoot + "." + ext
    end
    
  end
  
  wf = WineFile.new
  searchString = wf.readFile()
  
  searchString.sort!
  puts searchString[30]
  
end