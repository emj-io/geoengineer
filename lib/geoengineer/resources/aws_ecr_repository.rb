########################################################################
# AwsEcrRepository +aws_ecr_repository+ terrform resource,
#
# {https://www.terraform.io/docs/providers/aws/r/ecr_repository.html Terraform Docs}
########################################################################
class GeoEngineer::Resources::AwsEcrRepository < GeoEngineer::Resource
  validate -> { validate_required_attributes([:name]) }

  after :initialize, -> { _terraform_id -> { name } }

  def support_tags?
    false
  end

  def self._fetch_remote_resources(provider)
    AwsClients.ecr(provider).describe_repositories['repositories'].map { |name|
      {
        name: name,
        _geo_id: name,
        _terraform_id: name
      }
    }
  end
end
