class Api::V1::VersionsController < ApplicationController
    

    def create
        version = Version.create(title: params[:title], song_id: params[:id])
        version.recording = params[:recording]
        if version.save
            song = version.song
            sorted_versions = song.versions.order({ created_at: :desc }) 
            render json: {song: song, versions: sorted_versions} 
            # render json: sorted_versions
        else 
            render json: {song: song, versions: sorted_versions} 
        end 
    end

    def update
        version = Version.find(params[:id])
        version.title = params[:title]
        if version.save
            song = version.song
            sorted_versions = song.versions.order({ created_at: :desc }) 
            render json: {song: song, versions: sorted_versions}  
        else
            render json: {song: song, versions: sorted_versions} 
        end 
    end

    def destroy
        version = Version.find(params[:id])
        song = version.song 
        version.destroy
        sorted_versions = song.versions.order({ created_at: :desc }) 
        render json: {song: song, versions: sorted_versions}  
    end

end
