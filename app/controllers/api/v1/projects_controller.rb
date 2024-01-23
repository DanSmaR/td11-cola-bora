module Api
  module V1
    class ProjectsController < Api::V1::ApiController
      def index
        response = Project.all.as_json(only: %i[id title description category])

        response = { message: 'Nenhum projeto encontrado.' } if response.empty?

        render status: :ok, json: response
      end
    end
  end
end
