require 'spec_helper'

describe StudentsController, :type => :controller do


  it "should display students" do
    get :index
    expect(response).to be_ok
    expect(assigns(:students)).to include('Orion')
  end

  describe "schedule" do
    let(:student) { Student.create(:name => "Orion") }

    it "should show a students schedule" do
        meeting1 = {:id=>1,:period=>0,:duration=>30,:name=>"Arrival",:tags=>[]}
        schedule = [meeting1]
        get :show, { id: student.name}
        expect(response).to be_ok
        expect(assigns(:schedule)).to include(meeting1)
    end

    it "should return % time in instructional meetings" do
      get :show, { id: student.name }
      expect(assigns(:metrics)).to eq("Percentage of time spent in instructional courses" => "62%")
    end
  end


end