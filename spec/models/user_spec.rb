describe User do
  context 'validations' do
    it 'require that a name is present' do
      user = Fabricate.build(:user, name: nil)
      expect(user).to_not be_valid
      expect(user.errors[:name]).to include("can't be blank")
    end

    it 'requires password without github login' do
      user = Fabricate.build(:user, password: nil)
      expect(user).to_not be_valid
      expect(user.errors[:password]).to include("can't be blank")
    end

    it "doesn't require password with github login" do
      user = Fabricate.build(:user, password: nil, github_login: 'nashby')
      expect(user).to be_valid
    end

    it 'requires uniq github login' do
      user1 = Fabricate(:user, github_login: 'nashby')
      expect(user1).to be_valid

      user2 = Fabricate.build(:user, github_login: 'nashby')
      user2.save
      expect(user2).to_not be_valid
      expect(user2.errors[:github_login]).to include("is already taken")
    end

    it 'allows blank / null github_login' do
      user1 = Fabricate(:user, github_login: ' ')
      expect(user1).to be_valid

      user2 = Fabricate.build(:user, github_login: ' ')
      user2.save
      expect(user2).to be_valid
    end

    it "disables validations when reset password" do
      user = Fabricate.build(:user, email: '')
      user.save(validate: false)
      expect(user.reset_password('Password123', 'Password123')).to be_truthy
    end

    it 'should require a password with minimum of 6 characters' do
      user = Fabricate.build(:user)
      user.reset_password('12345', '12345')
      expect(user.errors[:password]).to include("is too short (minimum is 6 characters)", "is too short (minimum is 6 characters)")
    end
  end

  context "First user" do
    it "should be created this admin access via db:seed" do
      expect do
        allow($stdout).to receive(:puts).and_return(true)
        require Rails.root.join('db/seeds.rb')
      end.to change {
        User.where(admin: true).count
      }.from(0).to(1)
    end
  end

  context "GDS SSO additions" do
    describe "find_for_gds_oauth" do
      before :each do
        @oauth_hash = gds_omniauth_hash_stub('123456', :name => 'Testy McTest', :email => 'test@example.com')
      end

      it "should return falseish if given a hash missing the necessary details" do
        expect(User.find_for_gds_oauth({:foo => :bar})).to be false
        expect(User.find_for_gds_oauth({'info' => {}, 'extra' => {'user' => {}}})).to be false
      end

      it "should return falseish if the signon user doesn't have signin permission" do
        @oauth_hash['extra']['user']['permissions'] = %w(something)
        expect(User.find_for_gds_oauth(@oauth_hash)).to be false
      end

      context "without an existing user" do
        it "should create a user" do
          expect {
            User.find_for_gds_oauth(@oauth_hash)
          }.to change { User.count }.by(1)
        end

        it "should populate the user details" do
          u = User.find_for_gds_oauth(@oauth_hash)

          expect(u).to be_persisted
          expect(u.uid).to eq('123456')
          expect(u.name).to eq('Testy McTest')
          expect(u.email).to eq('test@example.com')
        end

        it "should set the admin flag and permissions" do
          u = User.find_for_gds_oauth(@oauth_hash)
          expect(u).not_to be_admin
          expect(u.permissions).to eq(['signin'])

          @oauth_hash['extra']['user']['permissions'] = %w(signin admin)
          u = User.find_for_gds_oauth(@oauth_hash)
          expect(u).to be_admin
          expect(u.permissions).to eq(['signin', 'admin'])
        end

        it "should return a falseish value if the user can't be created" do
          @oauth_hash['info']['email'] = "not an email address"

          expect(User.find_for_gds_oauth(@oauth_hash)).to be false
        end
      end

      context "with an existing user" do
        before :each do
          @user = Fabricate(:user, :uid => '123456')
        end

        it "should update the user details" do
          u = User.find_for_gds_oauth(@oauth_hash)

          @user.reload
          expect(@user.name).to eq('Testy McTest')
          expect(@user.email).to eq('test@example.com')
        end

        it "should update the permissions and admin flag" do
          @user.update_attributes!(:admin => true)

          User.find_for_gds_oauth(@oauth_hash)
          expect(@user.reload).not_to be_admin
          expect(@user.permissions).to eq(['signin'])

          @oauth_hash['extra']['user']['permissions'] = %w(signin admin)
          User.find_for_gds_oauth(@oauth_hash)
          expect(@user.reload).to be_admin
          expect(@user.permissions).to eq(['signin', 'admin'])
        end

        it "should return falseish if the user can't be updated" do
          @oauth_hash['info']['email'] = "not an email address"

          expect(User.find_for_gds_oauth(@oauth_hash)).to be false
        end
      end

    end
  end
end
