class TwireLinkController < ApplicationController

    def index
        @hubs = TwireLink.all
    end
end
