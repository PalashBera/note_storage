require "rails_helper"

RSpec.describe ApplicationController, type: :controller do
  let!(:user) { create(:user) }

  controller do
    def after_sign_in_path_for(resource)
      stored_location_for(resource) || notes_path
    end
  end

  describe "after sig in redirection" do
    it "redirects to the /notes page" do
      expect(controller.after_sign_in_path_for(user)).to eq(notes_path)
    end
  end
end
