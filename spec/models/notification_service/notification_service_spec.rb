describe NotificationService, type: 'model' do

  let(:notice) { Fabricate :notice }
  let(:notification_service) { Fabricate :notification_service, :app => notice.app }
  let(:problem) { notice.problem }

  it "it should use http by default in #problem_url" do
    expect(notification_service.problem_url(problem)).to start_with 'http://'
  end

  it "it should use the protocol value specified in the config in #problem_url" do
    Errbit::Config.protocol = 'https'
    expect(notification_service.problem_url(problem)).to start_with 'https://'
  end
end
