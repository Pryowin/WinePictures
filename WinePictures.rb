require 'google-search'
require 'csv.rb'
require 'open-uri'
require 'open_uri_redirections'
require 'net/https'  

module WinePictures
  
  class FileNameUtil
    LABEL_PATH_NAME = "D:/Users/David/Pictures/WineLabels/"
         
    def isLabelPresent (labelName)
      fqn = LABEL_PATH_NAME + labelName
      return !Dir.glob(fqn).empty?
    end   
    
    def fullyQualifiedName (fileName)
      return LABEL_PATH_NAME + fileName
    end
  end
    
  class WineFile
    
    PATH_NAME = "D:/Users/David/Workspace/WinePictures/"
    FILE_NAME = "export-bottles-stored.csv"
    WILD_CARD = "*"
   
    @lastBottle = String.new()
    @@fnu = FileNameUtil.new()
   
    def readFile
      fqn = PATH_NAME + FILE_NAME
      i=0
      bottleDesc = Array.new()
      
      CSV.foreach(fqn,  encoding: "bom|UTF-8", :row_sep => :auto, :headers => true) do |bottle|   
          if bottle['Name'] != ""
            desc = "#{bottle['Winery']} #{bottle['Name']} label"
          else
            desc = "#{bottle['Winery']} #{bottle['Grapes']} label"
          end
          bottleDesc[i] = BottleName.new(desc)
          i +=  1
      end
      return bottleDesc
    end
    
    def isNewBottle(bottle)

      if bottle.searchName == @lastBottle
           return false
      end
      @lastBottle = bottle.searchName   
      
      if @@fnu.isLabelPresent(bottle.fileName(WILD_CARD))
        return false
      else
        bottle.setUri()
        return true
      end
    
    end
    
  end
  
  
  
  class BottleName
    
    def initialize(name)
      @searchName = name.gsub("'","")
      @fileRoot = @searchName.to_s.gsub(" ","_")
      @uri =""
    end
    
    def searchName
      return @searchName
    end
    
    def fileRoot
      return @fileRoot
    end
      
    def fileName (ext)
      return fileRoot + ext
    end
    
    def setUri
      @uri = Google::Search::Image.new(:query => @searchName).first.uri 
    end
    
    def uri
      return @uri
    end
    
  end
  
 
  WRITE_BINARY = "wb"
  fnu = FileNameUtil.new 
  wf = WineFile.new
  bottles = wf.readFile()
  
  for index in 0 ... bottles.size
    bottle = bottles[index]
    if wf.isNewBottle(bottle)
      ext =  File.extname(bottle.uri)
      qm = ext.index("?")
      if !qm.nil?
        ext = ext[0 ... qm]
      end 
      fileName = bottle.fileName(ext)
      puts fnu.fullyQualifiedName(fileName)
      File.open(fnu.fullyQualifiedName(fileName), WRITE_BINARY) do |fo|
        fo.write open(bottle.uri, {ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE,  :allow_redirections => :all}).read 
      end
    end
  end
  
end 