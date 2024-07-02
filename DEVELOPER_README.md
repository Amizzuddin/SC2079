# Getting Started

Software Engineering

- [sc2006_project](#sc2006_project)
   - [Getting Started](#getting-started)
      - [Prerequisites](#prerequisites)
      - [Getting things running](#getting-things-running)
   - [Guides](#guides)
      - [Github](#github)
         - [Create New Branch](#create-new-branch)
         - [Commit and Push (Sync)](#commit-and-push-sync)
         - [Linking Commits to JIRA via smart commit](#linking-commits-to-jira-via-smart-commit)
         - [Demo on Smart Commit](#demo-on-smart-commit)
         - [Commit practices](#commit-practices)
         - [Pull Request](#pull-request)
         - [Rebase](#rebase)
         - [Other Notes](#other-notes)

## Prerequisites

Making assumption that you will be working on Windows OS, You will require to download the following tools to get started

1. [Visual Studio Code](https://code.visualstudio.com/download): IDE that supports devcontainer. Please make sure you install Version 1.89.1
2. [Docker]([doc](https://www.docker.com/products/docker-desktop/)): Development will be done in devcontainer, The reason for this approach so all of us will be using the same tools. In addition, I did not upload the docker image on docker hub registry because I want to keep the image as private. In other words you are required to build the image on your local machine
3. [WSL2](https://learn.microsoft.com/en-us/windows/wsl/install): For convenience, I strongly recommend that you have WSL2 installed on your windows machine as I am running the same setup as well. This way I can support if you have difficulties in getting things setup. More importantly, this will reduce the headache to setup MS SQL database, GIT related actions and etc.

**NOTE**: If you are working on Linux or MAC, you will not need WSL2 setup

## Getting things running

Once you have the step [above](#prerequisites), you will need to do the following:

1. [Setup Github SSH keys](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent): This will ne needed for easier git actions such as commit, push and PR
2. Run/Launch both docker your machine. You dont have to do anything else, Just make sure docker is running cause this step is required to run docker containers on WSL2
3. Start WSL2, this should  take you to `/home` directory of the Ubuntu terminal (WSL2 only support Ubuntu distros)Clone this repository but the following command
4. Run the command below:
   ```
   git clone git@github.com:Amizzuddin/sc2006_project.git
   ```
   This should create a folder named `sc2006_prject` on your `/home` directory
5. Now change your directory to the root of the repository by using the following command:

   ```
   cd ~/sc2006_project
   ```
6. Ensure you are at the right directory, you can execute the following command:

   ```
   pwd
   ```

   you should have something like `/home/<username>/sc2006_project` unless you place the repository some other directory this will be different from the provided example
7. Next, buil the image, Run the following command:

   ```
   bash build_image.sh
   ```
8. Once build image is successful, when you run the following command:

   ```
   docker images 
   ```

   you should have the following printout:

   ```
   REPOSITORY                       TAG           IMAGE ID       CREATED        SIZE
   sc2006_project                   latest        633becd50066   7 days ago     576MB
   sc2006_project_dev               latest        66863a2e457c   7 days ago     647MB
   mcr.microsoft.com/mssql/server   2022-latest   ffdd6981a89e   2 months ago   1.58GB
   ```

   **NOTE**: Running this script will build both Development and Production image. I understand it is not a smart way to build both image when Production is not ready but let it be this way for now.
   REMARKS: If you have issue and not sure how to go about, DO NOT HESITATE to contact me. Please do it over teams cause I can at least see your screen

9. Run VSCode by the following command:

   ```
   code .
   ```

11. Now proceed to run the VScode in devcontainer mode. Refer the below image for more guide:
   ![Devcontainer Guide](/media/DevcontainerGuide.gif)
12. You should be good for develoment now

## Guides

### Github

Some of you may not be familiar with Github, I have include images on how to get you get up and running.

#### Create New Branch

The practice for creating new branch is based on your name. DO NOT USE MAIN BRANCH FOR YOUR DEVELOPMENT!!! This is because its easier to backtrack for any problems with newly merge changes. Remember we do not do any CI/CD. Meaning the only way to tell is merge is good is to manually run the program
![Git Create Branch Guide](/media/GitCreateNewBranchGuide.gif)

#### Commit and Push (Sync)

##### Linking Commits to JIRA via smart commit

Smart commit only requires you to identify the JIRA task you are currently working. You can either view your task via [webpage](https://amiz0001.atlassian.net/jira/software/projects/SWENG/boards/1/backlog) or from JIRA VSCode extension as per below screenshot:
![JIRA VSCode Extension View](/media/JiraVSCodeExtensionView.png)

##### Demo on Smart Commit

![Smart Commit Demo](/media/SmartCommitGuide.gif)

##### Commit practices

The practice for GIT commit is to put meaningful message so its easier for you to track the history. Here are some addition guide regarding Git commits
![Git Commit guide](/media/GitCommitGuide.gif)

#### Pull Request

When your changes are updated, raise a PR to merge into the `origin/main` branch
![Git Pull Request Guide](/media/GitPullRequestGuide.gif)

#### Rebase

ALWAY REBASE your working branch if there is ANY branch merge with origin/main branch. This way, your code is always to date with origin/main. At the same time, changes made by other developer does not reflect on your branch when you raise a PR
![Git Rebase Guide](/media/GitRebaseGuide.gif)

#### Other Notes

If you have any problems with github, Dont hesistate to contact me. make a habbit to do small commit and push cause this will keep a record of your changes on server which is safer than placing them on your local machine. Once your code lost there is no way to retrieve it if you leave it on local machine
