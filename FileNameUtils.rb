

module FileNameUtils
   
  class FileNameUtils
    
    LABEL_PATH_NAME = "D:/Users/David/Pictures/WineLabels/"
    def isLabelPresent (labelName)
      
      fqn = LABEL_PATH_NAME + labelName
      
      return !Dir.glob(fqn).empty?
      
    end
  end
end