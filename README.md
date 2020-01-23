# redmine_restore_issue
Restore deleted issue from redmine <br>

Before restoring issue, restore dump from backup to temporary base and rename it in script.<br>
Usage: restore.sh #List issue number<br>
Example: 
```
./restore.sh 32830 23 98 76
```
In addition, you need to restore attachment files. Their locations can be found with this:
```
RAILS_ENV=production bin/rails r "Attachment.where(container_id: ${issue_id}).sort.each do |_a| puts _a.diskfile; end" 
```
P.S. Thanks guys from https://www.redmine.org/issues/1380
