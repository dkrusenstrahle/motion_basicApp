class Second

  # Set URL to use

  URL = "http://patriksjogren.comappo.com/api/v1/projects?access_token=iGFxKsCKFCo4pUCzctiz"

  # Set attributes for the model
 
  attr_accessor :id, :title, :description, :reference_number, :address, :zipcode, :city

  def initialize(attrs)

    # Create accessors

    attrs.each_pair do |key, value|
      self.send("#{key}=", value)
    end
  end

  def self.from_json(json)

    # Create new object from JSON

    new(:id => json["id"], 
        :title => json["title"], 
        :description => json["description"], 
        :reference_number => json["reference_number"], 
        :address => json["address"],
        :zipcode => json["zipcode"],
        :city => json["city"])
  end

  def self.fetch_content(&block)

    # Make the actual call to the API
    
    BubbleWrap::HTTP.get(URL) do |response|
      if response.ok?
        json = BubbleWrap::JSON.parse(response.body)
        if json['total'] > 0
          projects = json['projects'].map {|ej| self.from_json(ej["project"])}
          block.call(true, projects)
        else
          block.call(false, nil)
        end
      else
        block.call(false, nil)
      end
    end
  end
end