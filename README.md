# Katsudo

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'katsudo'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install katsudo

## Usage

First create model by hand: STI and Polymorphic

    $ rails generate model Activity type:string resource_type:string resource_id:integer user_type:string user_id:integer
    $ rake db:migrate

Now define any users models to be a subject of activity:

    class User < ActiveRecord::Base
      activity_user!
    end

    class Admin < ActiveRecord::Base
      activity_user!
    end

Controller:

    # application_controller.rb:
   
    def activity_user
      current_admin||current_user # an accessor to current activity subject. I use Devise and all helpers built in.
    end

    # common controller action:

    def create
      respond_to do |format|
        if @comment.save
          flash << activity_message(:create_object, @comment)
          format.html { redirect_to [@article, @comment] }
        else
          format.html { render action: "new" }
        end
      end
    end
  
Model:

    class CreateObject < Activity
      def title
        "Saved!"
      end

      def message
        "#{resource.class.model_name.human} was created"
      end
    end

Partial for activity:

    # views/activities/create_object.html.erb

    <strong><%= create_object.title %></strong>
    <p><%= create_object.message %></p>

If you want store each activity, add in controller as any filter:

    trace_activity :only => [:create, :update, :destroy]



## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
