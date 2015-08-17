require 'google-search'
require 'csv.rb'

module WinePictures
  
  class WineFile
    
    PATH_NAME = "D:\\Users\\David\\Workspace\\WinePictures\\"
    FILE_NAME = "export-bottles-stored.csv"
    
    def readFile
      fqn = PATH_NAME + FILE_NAME
      i=0
      winery =Array.new
      name = Array.new
      
      CSV.foreach(fqn,  encoding: "bom|UTF-8", :row_sep => :auto, :headers => true) do |bottle|
          winery[i] = bottle['Winery']
          name [i] = bottle ['Name']   
          i += 1
      end
     return winery,name
    end
    
   
     
  end
  
  wf = WineFile.new
  wf.readFile()
  
end