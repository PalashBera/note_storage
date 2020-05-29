require "rails_helper"

RSpec.describe NotesController do
  let!(:user) { create(:user) }
  let!(:note) { create(:note, user: user) }

  describe "GET index" do
    it "requires login" do
      sign_out user
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end

    it "returns http status 200" do
      sign_in user
      get :index
      expect(response).to have_http_status(:ok)
    end

    it "populates instance variable with an array of notes" do
      sign_in user
      get :index
      expect(assigns(:notes)).to eq([note])
    end
  end

  describe "GET #new" do
    it "requires login" do
      sign_out user
      get :new
      expect(response).to redirect_to(new_user_session_path)
    end

    it "returns http status 200" do
      sign_in user
      get :new, params: { id: note.id }
      expect(response).to have_http_status(:ok)
    end

    it "assigns a new note to an instance variable" do
      sign_in user
      get :new
      expect(assigns(:note)).to be_a_new(Note)
    end
  end

  describe "GET #edit" do
    let!(:user1) { create(:user) }
    let!(:note1) { create(:note, user: user1) }

    it "requires login" do
      sign_out user
      get :edit, params: { id: note.id }
      expect(response).to redirect_to(new_user_session_path)
    end

    context "with authorized id" do
      it "returns http status 200" do
        sign_in user
        get :edit, params: { id: note.id }
        expect(response).to have_http_status(:ok)
      end

      it "assigns the requested note to an instance variable" do
        sign_in user
        get :edit, params: { id: note.id }
        expect(assigns(:note)).to eq(note)
      end
    end

    context "with unauthorized id" do
      it "returns http status 200" do
        sign_in user
        get :edit, params: { id: note1.id }
        expect(response).to have_http_status(:found)
      end

      it "assigns the requested note to an instance variable" do
        sign_in user
        get :edit, params: { id: note1.id }
        expect(assigns(:note)).to eq(note1)
      end

      it "redirect to notes_path" do
        sign_in user
        get :edit, params: { id: note1.id }
        expect(response).to redirect_to(notes_path)
      end
    end
  end

  describe "POST #create" do
    it "requires login" do
      sign_out user
      post :create, params: { note: { title: "Hello World", body: "How are you?", user_id: user.id }}
      expect(response).to redirect_to(new_user_session_path)
    end

    context "with valid attributes" do
      it "saves the new note in the database" do
        sign_in user
        expect {
          post :create, params: { note: { title: "Hello World", body: "How are you?", user_id: user.id }}
        }.to change(Note, :count).by(1)
      end

      it "returns http status 302" do
        sign_in user
        post :create, params: { note: { title: "Hello World", body: "How are you?", user_id: user.id }}
        expect(response).to have_http_status(:found)
      end

      it "assigns a newly created but unsaved note to an instance variable" do
        sign_in user
        post :create, params: { note: { title: "Hello World", body: "How are you?", user_id: user.id }}
        expect(assigns(:note)).to be_a(Note)
        expect(assigns(:note)).to be_persisted
      end

      it "redirects to note show page" do
        sign_in user
        post :create, params: { note: { title: "Hello World", body: "How are you?", user_id: user.id }}
        expect(response).to redirect_to(notes_path)
      end
    end

    context "with invalid attributes" do
      it "does not save the new note in the database" do
        sign_in user
        expect{
          post :create, params: { note: { title: "", body: "How are you?", user_id: user.id }}
        }.not_to change(Note, :count)
      end

      it "assigns a newly created but unsaved note an instance variable" do
        sign_in user
        post :create, params: { note: { title: "", body: "How are you?", user_id: user.id }}
        expect(assigns(:note)).to be_a_new(Note)
      end

      it "returns http status 200" do
        sign_in user
        post :create, params: { note: { title: "", body: "How are you?", user_id: user.id }}
        expect(response).to have_http_status(:ok)
      end

      it "re-renders the :new template" do
        sign_in user
        post :create, params: { note: { title: "", body: "How are you?", user_id: user.id }}
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PATCH #update" do
    it "requires login" do
      sign_out user
      patch :update, params: { id: note.id, note: { title: "Hello World", body: "How are you?" }}
      expect(response).to redirect_to(new_user_session_path)
    end

    context "with valid attributes" do
      it "updates the requested note" do
        sign_in user
        patch :update, params: { id: note.id, note: { title: "Hello World", body: "How are you?" }}
        note.reload
        expect(note.title).to eq("Hello World")
        expect(note.body).to eq("How are you?")
      end

      it "returns http status 302" do
        sign_in user
        patch :update, params: { id: note.id, note: { title: "Hello World", body: "How are you?" }}
        expect(response).to have_http_status(:found)
      end

      it "assigns the requested note to an instance variable" do
        sign_in user
        patch :update, params: { id: note.id, note: { title: "Hello World", body: "How are you?" }}
        expect(assigns(:note)).to eq(note)
      end

      it "redirects to note show page" do
        sign_in user
        patch :update, params: { id: note.id, note: { title: "Hello World", body: "How are you?" }}
        expect(response).to redirect_to(notes_path)
      end
    end

    context "with invalid attributes" do
      it "does not update the requested note" do
        sign_in user
        expect {
          patch :update, params: { id: note.id, note: { title: "", body: "How are you?" }}
        }.not_to change { note.reload.attributes }
      end

      it "assigns the note to an instance variable" do
        sign_in user
        patch :update, params: { id: note.id, note: { title: "", body: "How are you?" }}
        expect(assigns(:note)).to eq(note)
      end

      it "returns http status 200" do
        sign_in user
        patch :update, params: { id: note.id, note: { title: "", body: "How are you?" }}
        expect(response).to have_http_status(:ok)
      end

      it "re-renders the :edit template" do
        sign_in user
        patch :update, params: { id: note.id, note: { title: "", body: "How are you?" }}
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do
    it "requires login" do
      sign_out user
      delete :destroy, params: { id: note.id }
      expect(response).to redirect_to(new_user_session_path)
    end

    it "returns http status 302" do
      sign_in user
      delete :destroy, params: { id: note.id }
      expect(response).to have_http_status(:found)
    end

    it "deletes the note" do
      sign_in user
      expect{
        delete :destroy, params: { id: note.id }
      }.to change(Note, :count).by(-1)
    end

    it "redirects to note show page" do
      sign_in user
      delete :destroy, params: { id: note.id }
      expect(response).to redirect_to(notes_path)
    end
  end
end
