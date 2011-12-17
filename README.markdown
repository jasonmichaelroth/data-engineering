# Challenge for Software Engineer - Big Data

Here are the instructions for this challenge:

> 1. Your app must accept (via a form) a tab delimited file with the following columns: purchaser name, item description, item price, purchase count, merchant address, and merchant name.  You can assume the columns will always be in that order, that there will always be data in each column, and that there will always be a header line.  An example input file named example_input.tab is included in this repo.
> 1. Your app must parse the given file, normalize the data, and store the information in a relational database.
> 1. After upload, your application should display the total amount gross revenue represented by the uploaded file.
>
> Your application does not need to:
>
> 1. handle authentication or authorization (bonus points if it does, extra bonus points if authentication is via OpenID)
> 1. be written with any particular language or framework
> 1. be aesthetically pleasing
>
> Your application should be easy to set up and should run on either Linux or Mac OS X.  It should not require any for-pay software.


## Install & Run

You must have ruby 1.9 and bundler installed.

Clone the repository and install the gems

    $> git clone [repo url]
    ...
    $> bundle install
    ...

Create and setup the database:

    $> rake db:setup
    ...

Run the tests (rspec):

    $> rake spec
    ...

Start the server

    $> rails s
    ...

Visit the app at [http://locahost:3000](http://localhost:3000/). You will be prompted to log. Click the OpenID link and log in via your OpenID credentials. This will take you to the import form where you can choose a tab file to upload. 

Choos a file and click "Import" to import the data. Assuming there are no errors in the tab file, the data will be imported and you will see the gross revenue from the imported file.

> Note that if there are any data errors in the file, you will be notified which line produced the error and the import will fail.
