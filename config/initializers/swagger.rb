Swagger::Docs::Config.base_api_controller = ActionController::API
Swagger::Docs::Config.register_apis({
 "1.0" => {
   :api_extension_type => :json,
   :api_file_path => "public/apidocs",
   :base_path => "http://localhost:3000",
   :clean_directory => true,
   :attributes => {
     :info => {
       "title" => "Swagger Sample App",
       "description" => "This is a sample description.",
       "termsOfServiceUrl" => "http://somedomain.com/terms/",
       "contact" => "apiteam@somedomain.com",
       "license" => "Apache 2.0",
       "licenseUrl" => "http://www.apache.org/licenses/LICENSE-2.0.html"
     }
   }
 }
})

class Swagger::Docs::Config
  def self.transform_path path, api_version
    "apidocs/#{path}"
  end
end
