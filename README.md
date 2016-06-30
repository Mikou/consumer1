# Consumer application

This is an example of a consumer application for VisTool. It depends on the 
VisTool kernel in order to generate a user interface:
[https://github.com/Mikou/uvis](https://github.com/Mikou/uvis)

In order to install the application:

  npm install

After the installation it can be started:

  npm start

When started, the application will lookup the JavaScript kernel at the address 
provided in the script tag in `public/index.html`. A tiny css file is also
downloaded in order to position the toolbox.

The location of the kernel depends on you specific local setup.
