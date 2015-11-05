#Git Directions
Basic directions for creating branches, merging, and keeping your own branch up to date.

##Start working
Move onto master. ALWAYS DO THIS FIRST

`$ git checkout master` 		
			
Pull any new changes to master

`$ git pull`

Create the new branch and move onto it

`$ git checkout -b <branch_name>`

##Committing Changes
Add your changes to staging.<sup>1</sup> 

`$ git add <file_name>`

Commit your changes <sup>2</sup> 

`$ git commit -m "commit message"`

Push your local changes to your remote Directory

`$ git push origin <branch_name`

Finally, if this is your first commit, go onto the repo page on Github and open a pull request

____
<sup>1</sup> You can either specify the file name or add all the files. I recommend adding files one by one, esp. when you create things like view controllers and XCode generates a ton of files, including ones with personal data.

<sup>2</sup> If you forget the `-m` flag you get kicked into vim. Press `i` for insert mode, type whatever you want for the message and press the `escape`key to exit insert mode. Finally, add `:wq`to write your changes and quit vim, then press `enter`. **Tl;dr** always use the `-m` flag.

##Merging with master
Move onto master

`$ git checkout master` 					

Update origin/master with remote changes

`$ git pull`								

Move onto your branch

`$ git checkout <branch_name>` 			

Pulls the changes from master

`$ git fetch`	

Adds changes to master into branch			 	
`$ git rebase origin/master`

Merge your branch into master							
`$ git push origin <branch_name>:master` 	


##After merging, delete branch
Move onto master

`$ git checkout master` 

delete the remote branch
					
`$ git push origin :<branch_name>`

Delete the local branch (make sure the flag is capitalized)
 		
`$ git brand -D <branch_name>`			
