This use Jenkins, Github, Docker to manages complete workflow from Development of code to checking the code for Production and deploying to the production.

How it Works?
## Step 1:
download the code whenever developer pushes the code into the repository.
and copy it to `/tmp/MlOps-Task-2` folder.

<img src="/Gif's/Get-The-Code.gif" alt="Get-The-Code" width="600" height="400">

We've used this code for the same

```Shell
if sudo ls -l /tmp/ | grep MlOps-Task-2
then 
sudo cp -rvf Code/* /tmp/MlOps-Task-2/
else
sudo mkdir /tmp/MlOps-Task-2/
sudo cp -rvf Code/* /tmp/MlOps-Task-2/
fi
```

## Step 2:
Check the file for file type from it's extention. Run the Container according to file type.

<img src="Gif's/Run-The-Container.gif" alt="Run-The-Container" width="600" height="400">

We've used this code for the same

```Shell
if sudo ls -l /tmp/MlOps-Task-2/ | grep .py
then 
	sudo docker run -d --rm --name python -v /tmp/MlOps-Task-2/:/usr/src/myapp -w /usr/src/myapp python:rc-alpine3.12 python *.py
fi

if sudo ls -l /tmp/MlOps-Task-2/ | grep .html
then 
	sudo docker run -d --name html-server -p 8081:80 -v /tmp/MlOps-Task-2/:/usr/local/apache2/htdocs/ httpd
fi
```
