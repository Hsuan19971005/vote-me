class CandidatesController < ApplicationController
  def index
    @candidates = Candidate.all
  end
  def show
    @candidate = Candidate.find_by(id: params[:id])
  end
  def new
    @candidate = Candidate.new
  end

  def create
    @candidate = Candidate.new(candidate_params)
    if @candidate.save
      flash[:notice] = "Add new candidate success!"
      redirect_to '/candidates'
    else
      # redirect_to '/candidates/new'
      render :new
    end
  end
  def edit
    @candidate = Candidate.find_by(id: params[:id])
  end
  def update
    @candidate = Candidate.find_by(id: params[:id])
    if @candidate.update(candidate_params)
      flash[:notice] = "Update success!"
      redirect_to '/candidates'
    else  
      render :edit
    end
  end
  def destroy
    @candidate = Candidate.find_by(id: params[:id])
    @candidate.destroy
    flash[:notice] = "You destroy the data!"
    redirect_to "/candidates"
  end
  def vote
    @candidate = Candidate.find_by(id: params[:id])
    @candidate.increment(:votes)
    @candidate.save
    flash[:notice] = "You voted."
    redirect_to "/candidates"
  end

  private
  def candidate_params
    params.require(:candidate).permit(:name, :party, :age, :politics)
  end
end
