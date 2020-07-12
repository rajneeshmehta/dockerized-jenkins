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
we can confirm this from running `docker container ps -a` command.
```
[root@localhost ~]# docker container ps -a
CONTAINER ID        IMAGE               COMMAND              CREATED             STATUS                     PORTS                  NAMES
20127f4e0827        httpd               "httpd-foreground"   15 hours ago        Exited (255) 2 hours ago   0.0.0.0:8081->80/tcp   html-server
[root@localhost ~]# 
```
## Step 3:
check the app status from concept of exit code in case of html.

<img src="Gif's/Test-the-App.gif" alt="Run-The-Container" width="600" height="400">

We've used this code for the same

```Shell
if sudo ls /tmp/MlOps-Task-2 | grep .html
then
	html_status = $( curl -o /dev/null -s -w "%{http_code}" ttp://192.168.43.61:8081/index.html)
fi


if $html_status=="200"
then
	exit 1
else
	exit 0
fi


if sudo docker ps -af status=exited -f name=python
then
	exit 0
fi
```
> #### It'll also inform the developer if job failed indicating any app not running well.

## Step 4:
If any Container fails duet to any reasons we'll restart the container.

<img src="/Gif's/restart-Container.gif" alt="Restart-The-Container" width="600" height="400" >

We've used this code for the same
```Shell
if sudo docker container ps -af name=python -f status=exited 
then 
	sudo docker container start python
fi

if sudo docker container ps -af name=html-server -f status=exited 
then 
	sudo docker container start html-server
fi

```
## Step 5:
Now we'll create a Build Pipeline view.

<img src="/Gif's/Build-Pipeline.gif" alt="Build-Pipeline" width="600" height="400">

