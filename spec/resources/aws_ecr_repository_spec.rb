require_relative '../spec_helper'

describe(GeoEngineer::Resources::AwsEcrRepository) do
  common_resource_tests(described_class, described_class.type_from_class_name)

  describe "#_fetch_remote_resources" do
    it 'should create list of hashes from returned AWS SDK' do
      ecr = AwsClients.ecr
      stub = ecr.stub_data(
        :describe_repositories,
        {
          repositories: [
            {
              repository_name: "testrepo1",
              repository_arn: "arn:aws:ecr:us-east-1:012345678901:repository/testrepo1",
              registry_id: "012345678901",
              repository_uri: "012345678901.dkr.ecr.us-east-1.amazonaws.com/testrepo1",
              created_at: Time.now.utc
            },
            {
              repository_name: "testrepo2",
              repository_arn: "arn:aws:ecr:us-east-1:012345678901:repository/testrepo2",
              registry_id: "012345678901",
              repository_uri: "012345678901.dkr.ecr.us-east-1.amazonaws.com/testrepo2",
              created_at: Time.now.utc
            }
          ]
        }
      )
      ecr.stub_responses(:describe_repositories, stub)
      remote_resources = GeoEngineer::Resources::AwsEcrRepository._fetch_remote_resources(nil)
      expect(remote_resources.length).to eq 2
    end
  end
end
