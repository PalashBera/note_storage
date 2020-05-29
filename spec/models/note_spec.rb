require "rails_helper"

RSpec.describe Note, type: :model do
  let!(:user) { create(:user) }
  let!(:note) { create(:note, title: "My Note", tag_list: "demo, note", user: user) }

  describe "validation" do
    context "when title is not present" do
      it "should not validate the note" do
        expect(FactoryBot.build(:note, title: "")).to_not be_valid
      end
    end

    context "when title is taken for same user" do
      it "should not validate the note" do
        expect(FactoryBot.build(:note, title: "My Note", user: user)).to_not be_valid
      end
    end

    context "when body is not present" do
      it "should not validate the note" do
        expect(FactoryBot.build(:note, body: "")).to_not be_valid
      end
    end

    context "when title and body is present and title is not taken" do
      it "should validate the note" do
        expect(FactoryBot.build(:note, title: "Personal Note", body: "I am happy.", user: user)).to be_valid
      end
    end
  end

  describe "#display_tags" do
    it "should return tags" do
      expect(note.display_tags).to eq("demo, note")
    end
  end
end
