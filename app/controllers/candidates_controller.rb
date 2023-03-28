class CandidatesController < ApplicationController
  before_action :find_candidate, only: [:show, :edit, :update, :destroy, :vote]
  def index
    @candidates = Candidate.all
    if params[:keyword].present?
      @candidates = @candidates.where("name like ?", "%#{params[:keyword]}%").or(@candidates.where("party like ?", "%#{params[:keyword]}%"))
    end
  end
  
  def show
  end
  
  def new
    @candidate = Candidate.new
  end

  def create
    @candidate = Candidate.new(candidate_params)
    if @candidate.save
      redirect_to '/candidates', notice: "Add new candidate success!"
    else
      render :new
    end
  end

  def edit
  end
  
  def update
    if @candidate.update(candidate_params)
      redirect_to '/candidates', notice:"Update success!"
    else  
      render :edit
    end
  end
  
  def destroy
    @candidate.destroy
    redirect_to "/candidates", notice: "You destroy the data!"
  end

  def vote
    # VoteLog.create(candidate: @candidate, ip_address: request.remote_ip)
    @candidate.vote_logs.create(ip_address: request.remote_ip)

    redirect_to "/candidates",notice:"You voted."
  end

  private
  def candidate_params
    params.require(:candidate).permit(:name, :party, :age, :politics)
  end
  def find_candidate
    @candidate = Candidate.find(params[:id])
  end
end
