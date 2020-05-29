# Welcome to Note Storage

This is a simple note storage application using Ruby on Rails. For demo of this application please follow this link [Note Storage Demo Application](https://note-storage.herokuapp.com).

## Application Description
- User can signup into this application by providing email, password and password confirmation.
- After successful signup user will receive one confirmation mail. Without confirmation of mail use couldn't login into application. If user didn't receive any confirmation mail then user can send this instruction to email by using *Send confirmation* link.
- User can login into this application by providing email and password. In case user forgot the password, then user can recover password by using *Reset password* link. Here use will receive one instruction mail and reset the password.
- User can create note by clicking *New Note* button.
- User can edit note by clicking *Edit* link of respective note.
- User can delete note by clicking *Delete* link of respective note.
- User can search note by using search form.
- User can logout from application by clicking *Log Out* link at the navbar.
- User can update account information by clicking *Account Setting* at the navbar.
- If user wants to change email address then use has to confirm this email address again. For this confirmation user will receive one email after changing email address.
- If user want to delete account then can delete account and all notes by clicking *Delete Account* from account settings page.

## Technical Stack
- Ruby v2.6.6
- Rails v6.0.3
- Mongoid v7.1

## Development Setup

- Set up Ruby on Rails on linux based OS. For installation please follow this link [Ruby and Rails Installation Guide](https://gorails.com/setup/ubuntu/18.04). Here please use **RVM** for the development.
- Clone this repository into your system. [Clone GitHub Repository Guide](https://help.github.com/en/github/creating-cloning-and-archiving-repositories/cloning-a-repository)
- Open terminal and go to the project path.
- It will create one gemset for this project. Please install bundler first. For the installation of bundler please run this bellow command.
  > gem install bundler
- Install all gem by following bellow command.
  > bundle install
- Install MongoDB for database into this OS. Please follow this link [MongoDB Installation Guide](https://www.digitalocean.com/community/tutorials/how-to-install-mongodb-on-ubuntu-18-04).
- Start rails server with bellow command.
    > rails server
- Visit [http://localhost:3000](http://localhost:3000). You are on home page.

## Testing

Rspec is there for unit testing. After running test suite one test coverage will be generated inside the project folder. For this test coverage *SimpleCov* has been used.
