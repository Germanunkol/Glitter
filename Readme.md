Glitter - A shader collection for Löve2D
========================================


This is a collection of shaders for Löve2D. The goal of the project is to have multiple often-used shaders readily available.
Note: The shader code is Löve specific, but can easily be ported to other engines.

All of the code is freely available and released under the WTFPL license, _unless marked otherwise__. The images used for the examples are not part of that - see the License.txt for detail.

Examples
--------

All shaders come with an example. To try out the sample, make sure Löve (version 0.9.0 and up) is installed, then navigate to this folder and run:

    love .	(on Unix)
	C:\Program/ Files\Love\Love.exe . 	(or similar on Win)

The actual example files are in the Shaders/ subfolders. You can rip out any of the examples there and use it in your own projects.

Contributing
-------------

As mentioned above, the goal is to have many shaders available for free here. I will add more in the future, but please feel free to add your own!
Ideally, each shader should come with an example of how to use it.

Adding a shader:
-----------------------

- Fork the project
- Duplicate the Shaders/Plain folder so that you now have a folder Shaders/YourShader
- Rename the file "plain.lua" inside this new folder to yourshader.lua (must be the same name as your folder name, but all lower case!)
- Edit the functions and values inside. Each function is heavily documented in the code. If something's still unclear then check out the other shaders in the Shaders/ folder. If that still doesn't clear things up, [open an issue](https://github.com/Germanunkol/Glitter/issues) on GitHub.
- Make sure everything in your shader file is local. Only one table should be returned at the end.
- Make sure to heavily comment your code - the idea behind this project is to make the shaders as easy to integrate as possible.
- You may add a Readme.txt/.md and License.txt to the folder. Note: if you **don't** add a License.txt then the code you add will automatically be under the WTFPL, as described in the License.txt of the main folder.
- Send me the folder or a pull request.
