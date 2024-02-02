## Git Automations Script for Linux Bash

### Overview
This is a script for automating different git commands and processes, from creation of new local and remote 
repositories, adding remote repositories to local, adding, committing and pushing changes. 

The script was originally created to work on a linux machine, but will be updated to work on other operating systems in the future.

### Requirements/ Prerequisites
+ Linux machine running on bash shell
+ git version control installed locally
+ GitHub repository token

### How to set up git automations
+ Setting up git automations requires you to have these files locally. To do so, you must clone this repository and 
  follow these steps.
+ After cloning the repository locally, you need to set up environmental variables to be used in the automation 
  process, including git username, git email, and github token.

#### Setting variables and script to bash environment
Remember, you have to cd to this repository before performing the following actions

**Step 1: Add Git Username into your bash environment**
```
echo 'export GIT_USERNAME=YOUR_GIT_USERNAME' >> ~/.bashrc
```
Here is an example:
```
echo 'export GIT_USERNAME=Charles123' >> ~/.bashrc
```
**Step 2: Add git email into your bash environment**
```
echo 'export GIT_EMAIL=YOUR_GIT_EMAIL' >> ~/.bashrc
```
Here is an example:
```
echo 'export GIT_USERNAME=Charles123@gmail.com' >> ~/.bashrc
```
**Step 3: Add git token into your bash environment**
```
echo 'export GIT_EMAIL=YOUR_GIT_GITHUB_TOKEN' >> ~/.bashrc
```
Here is an example:
```
echo 'export GITHUB_TOKEN=github_pat_1144JHSHsdffsdJDDSDSD_SDFSHFSJHDjhjjshhasdjhsLKASDKHJ' >> ~/.bashrc
```
**Step 4: To run the script, you have to run `./git-automations [OPTIONS]` in the current directory. To make it 
possible to run the script from any location in your local machine, we need to Add the script folder to environmental 
path by running the following command.**
```
export PATH=$PATH:$(pwd)
```
**Step 5: You can run the script using the command `git-automations [OPTIONS]`. However, to avoid having to type the 
full name, we can create an alias command that is short and easy to remember.**
```
echo "alias run-git='git-automations'" >> ~/.bashrc
```

### Using Git Automations
This script integrates three common options, which are passed as arguments into the command, and which are common in 
handling major tasks in git version control. The options include the following:
+ create
+ commit
+ delete

#### How to use the above git options
Lets say you want to create a new repository both locally and remotely, be able to commit and push changes, delete a 
repository. You will need to run the command alias we have set for our script using one of the three options.

**1. Creating a new repository.**

To create a new repository, you will have to run the `run-git` command with the 
   `create` option
```
run-git create
```
**2. Updating changes to an existing repository.**

There are many commands we usually use in git to update changes made to a repository, including `git add  .`, `git commit -m "Commit Message"`, and `git push origin <branch>`. Most 
of these commands are integrated into the `commit` option of this script. All you have to do is use the `run-git` 
command with the `commit` option as follows.
```
run-git commit
```
**3. Deleting a Local and Remote Repository.**

Deleting repos is rare, but you might find yourself having to delete one. 
Use the command alias with the delete option as follows:
```
run-git delete
```
---------------------------------------------------
Authored by:
+ Julius Charles
