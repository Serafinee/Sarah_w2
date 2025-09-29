# Linking a new R project with remote repository in Github
#Write this in the terminal:

git init #Initializes git in your R project
git add . # stages all the files in your project
git commit -m "Message for commit" #Commits the staged files to your Git repository. Always include a descriptive messageregarding your change

#Connecting to the remote repository
git remote add origin <URL to GitHub repository>

git branch -M main  # Rename the branch to 'main' (if not already named 'main')
git push -u origin main # set main branch in remote repository

git rm -r --cached <name> # Stop tracking a file in the online repository (aka remove it from there)
  
#When starting your workflow, connect to Git hub by writing:
git pull #Pulls any upates from git Hub to your local computer
#Then you can work with whatever you need on the computer and finally do this:
git add . #Stages all files that have either been added or modified.
git commit -m "commit mesage" #Commits your stages
git push # push all your commits to Git Hub
