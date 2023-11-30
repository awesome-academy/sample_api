require "jwt"

class Authentication
  ALGORITHM = "HS256"

  class << self
    def encode payload
      JWT.encode(payload, "f02f544f3c922923a37d557f25a55c9f2fbda47832514abe639f98f974d81553", ALGORITHM)
    end

    def decode token
      JWT.decode(token, "f02f544f3c922923a37d557f25a55c9f2fbda47832514abe639f98f974d81553", true, {algorithm: ALGORITHM}).first
    end
  end
end
