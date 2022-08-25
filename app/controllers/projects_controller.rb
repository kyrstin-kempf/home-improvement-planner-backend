class ProjectsController < ApplicationController

    get "/projects" do
        @projects = Project.all 
        @projects.to_json(include: [:tasks])
    end
    
    get "/projects/:id" do
        project = Project.find(params[:id])
        project.to_json(include: [:tasks])
    end

    post "/projects" do
        # binding.pry
        project = Project.create(params)
        if project.save
            project.to_json
        else
            { errors: project.errors.full_messages, status: "Cannot process POST request" }.to_json
        end
    end
    
    patch "/projects/:id" do
        project = Project.find(params[:id])
        project.update(
            name: params[:name],
            priority: params[:priority]
        )
        project.to_json
    end
        
        delete '/projects/:id' do
            project = Project.find(params[:id])
            project.destroy
            project.to_json
        end
        
    end
    
    # patch "/projects/:id" do
    #     project = Project.find(params[:id])
    #     if project && project.update(params[:project])
    #         params[:tasks].each do |task_params|
    #             task = project.tasks.find(task_params[:id])
    #             task.update(task_params)
    #         end
    #         project.to_json(include: [tasks])
    #     else
    #         { errors: project.errors.full_messages, status: "Unable to process request"}
    #     end
    # end