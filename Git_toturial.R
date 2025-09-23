# Linking a new R project with remote repository in Github
#Write this in the terminal:

git init #Initializes git in your R project
git add . # stages all the files in your project
git commit -m "Message for commit" #Commits the staged files to your Git repository. Always include a descriptive messageregarding your change

#Connecting to the remote repository
git remote add origin <URL to GitHub repository>

git branch -M main  # Rename the branch to 'main' (if not already named 'main')
git push -u origin main

