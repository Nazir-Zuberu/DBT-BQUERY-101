### BigQuery

This is Google's serverlesss fully-managed data warehouse. It provides
- Fast SQL queries
- No infrastrature to manage
- Real-time analytics


### DBT(Data Build Tool): 

This is an SQL-based data transformation tool. It provide version control for transformations. It has built-in testing and documentation.

### Setting up and Integrating DBT with BigQuery

- go to pypi.org and search for dbt-bigquery
- copy the installation syntax

```bash
pip install dbt-bigquery
```

## Check version of dbt
    - dbt --version


## Initialize dbt
Initialize a dbt project 

    - dbt init dbt_bq
    - enter a number: 1
    - Desired authentication method option: 2
    - keyfile: Paths to keyfile.json: /Users/User-name/.dbt/dbt-bq.json
    - GCP project id: dbt-bq-101
    - dataset: dbt-bq
    - Threads: 1
    - job_execution_timeout_seconds [300]: press enter to continue
    - Desired location option: 1


# NB: We will have to replace project name and keyfile in the profiles.yml. 

## Log into GCP
- Create a new project
- Open BigQuery
    - Note that a project name similar to what we provided during configuration already exist
- Replace project value in profiles.yml with the project name in GCP BigQuery
    - Locate profile.yml at /Users/user-name/.dbt/
- Go IAM
    - Click on Service Account
    - Click on create service accout to create one
        - Provide service account name
        - Click on create and continue
        - Role: select owner
        - Click continue
        - Click done
    - Click on the created email link
    - Click on KEYS
        - Add key
            - create new key
            - select json and click on create
            - A json file will be downloaded. Copy this file to the directory containing the profiles.yml. Rename by removing the trailing alphanumeric characters. This might be the same as the name provided as keyfile.
            - Copy the path of the key file and replace keyfiles in the profiles.yml
            - Save the file


## Validate connection
- Go into the created dbt folder that contains dbt_project.yml. In our case dbt_bq
    - cd dbt_bq
- Run
    - dbt debug



# Folders and files in dbt_bq

- analysis: Used for analytical purposes
- logs: contains or stores logs
- macros: stores saved functions
- models: stores tables and views
- seeds: may contain initial data?
- snapshots
- tests
- dbt_project.yml: This file contains the configuration of the project. This is where to specify how your output(tables) should be. You can materialized(output/produce) into table or vies. Tables will have a solid grid attached to them in BigQuery and view will have a dotted grid-like symbol attached to them as well.

## Adding data sources to bigquery
- Click on ADD
- Click star a project by name. Adding a bigquery project to the explorer by project name. 
    - dbt-tutorial: this is a defaul dataset provided by dbt. 
    - Staring a project means adding the project to the explorer


## Using seed to add data to big
- Add csv file(s) to be upload into bigquery. Thus, seed is a means of uploading data from the local system into bigquery After adding the file to the seed folder, run the following command.
    - dbt seed

### Run written models
    - dbt run
    - dbt run --full-refresh # This will run and delete existing table if any before creating a new one


### Testing in DBT

This enables us to assert given conditions in our data warehouse. We specify conditions to be tested to ensure accurate usable data. 

Testing in DBT is done by creating a schema.yml file where all the rules and condition to be checked are stated. Test is performed by running the command:

```bash
dbt test
```
This will all the models stated in the schema.yml file and the various columns to check. 



### Generate documentation
```bash
dbt docs generate
```

### Serve and view documentation from the web
```bash
dbt docs serve
```