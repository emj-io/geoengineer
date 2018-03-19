########################################################################
# AwsEcrRepositoryPolicy +aws_ecr_repository_policy+ terrform resource,
#
# {https://www.terraform.io/docs/providers/aws/r/ecr_repository_policy.html Terraform Docs}
########################################################################
class GeoEngineer::Resources::AwsEcrRepositoryPolicy < GeoEngineer::Resource
  validate -> { validate_required_attributes([:repository, :policy]) }

  after :initialize, -> { _terraform_id -> { repository } }

  def support_tags?
    false
  end

  # def self._fetch_remote_resources(provider)
  #   client.describe_repositories['repositories']
  #         .map(&:repository_name)
  #         .map { |repository_name|
  #           begin
  #             client.get_repository_policy(repository_name: repository_name).repository_name
  #             {
  #               repository_name: repository_name,
  #               _geo_id: respository_name,
  #               _terraform_id: repository_name
  #             }
  #           rescue Aws::ECR::Errors::RepositoryPolicyNotFoundException => e
  #             nil
  #           end
  #         }
  # end
end
