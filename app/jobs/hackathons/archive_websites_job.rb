class Hackathons::ArchiveWebsitesJob < ApplicationJob
  queue_as :low

  def perform
    upcoming_or_recent_hackathons.find_each do |hackathon|
      Hackathons::ArchiveWebsiteJob.perform_later(hackathon)
    end
  end

  private

  def upcoming_or_recent_hackathons
    # Hackathons which are yet to happen or finished in the past month
    Hackathon.approved.where("ends_at >= ?", 1.month.ago)
  end
end
