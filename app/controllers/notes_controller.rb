class NotesController < ApplicationController
  before_action :authenticate_user!

  def index
    @notes = current_user.notes.search(params[:search])
  end

  def new
    @note = Note.new
  end

  def edit
    note
  end

  def create
    @note = Note.new(note_params)
    @note.user = current_user

    if @note.save
      redirect_to notes_path, flash: { success: "Note has been successfully created." }
    else
      render "new"
    end
  end

  def update
    if note.update(note_params)
      redirect_to notes_path, flash: { success: "Note has been successfully updated." }
    else
      render "edit"
    end
  end

  def destroy
    note.destroy
    redirect_to notes_path, flash: { danger: "Note has been successfully deleted." }
  end

  private

  def note
    @note ||= Note.find(params[:id])
    return @note if @note.user == current_user

    redirect_to notes_path, flash: { danger: "You tried to access unauthorized note." }
  end

  def note_params
    params.require(:note).permit(:title, :body, :tag_list)
  end
end
