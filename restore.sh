#!/bin/bash
#createdb restore_redmine_db
#cat restore_redmine_db.sql | psql restore_redmine_db
BACKUP_BASE='restore_redmine_db'
PROD_BASE='redmine'
tables='
  issues;id
  journals;journalized_id
  journal_details;journal_id
  custom_values;customized_id
  attachments;container_id
  time_entries;issue_id
  issue_relations;issue_from_id
'
issues=$@
for issue in $issues; do 
  echo "Restore issue: $issue"
  for i in $tables; do
    _t=${i%;*}; _id=${i#*;}; echo "t=$_t; _id=$_id";
    psql --command="COPY (SELECT * FROM ${_t} where ${_id} = ${issue}) TO STDOUT;" $BACKUP_BASE  | psql --command="COPY ${_t} FROM STDIN;" $PROD_BASE
  done
done
#dropdb restore_redmine_db
