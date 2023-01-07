#!/bin/bash

#Add source git-repo credentials" 
sourceUsername="  "
sourcePassword="  "

#Add destination git-repo credentials" 
destinationUsername="  "
destinationPassword="  "

#Add Git-repo https URL but without "https://" 
#For example: sourceGitRepo = github.com/Nishit2408/clone-from-one-repo-and-push-to-other-repo.git

sourceGitRepo="  "
destinationGitRepo="  "



##############################################################
###############cloning source repository#################

echo "Cloning source repository"
echo "                         "
if [ -d "$HOME/source" ]
then
	echo "repository already exits, taking pull ..."
	cd $HOME/source && git pull origin main
else
	echo "repository doesn't exits, taking clone ..."
git clone https://$sourceUsername:$sourcePassword@$sourceGitRepo $HOME/source
fi

##############################################################
###############cloning destination repository#################
echo "                         "
echo "                         "
echo "Cloning destination repository"
echo "                         "
if [ -d "$HOME/destination" ]
then
	echo "repository already exits, taking pull ..."
	cd $HOME/destination && git pull origin main
else
	echo "repository doesn't exits, taking clone ..."
git clone https://$destinationUsername:$destinationPassword@$destinationGitRepo $HOME/destination
fi

#####################################################################################
##############pull from source branch and push to destination branch#################
echo "                         "	 
echo "Enter the branch you want to take pull and push to destination repo"
read sourcebranch
cd $HOME/source && git pull origin $sourcebranch
cd $HOME/destination
git show-branch $sourcebranch &>/dev/null || git checkout -b $sourcebranch
rsync -avz --exclude=".git" $HOME/source/ $HOME/destination/
git status
git add .
git commit -m "pushed changes from source repo"
git push origin $sourcebranch
