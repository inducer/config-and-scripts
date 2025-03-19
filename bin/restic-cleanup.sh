#! /bin/bash
export XDG_CACHE_HOME=/mnt/andreas-backup/restic-repos/.cache
cd /mnt/andreas-backup/restic-repos/
echo "-------------------------------------------------------------"
echo "LAPTOP"
echo "-------------------------------------------------------------"
restic -r aklaptop/laptop/ forget --prune --keep-last 5 --keep-monthly 5 --keep-yearly 5
for machine in scicomp-discourse relate server grison; do
  echo "-------------------------------------------------------------"
  echo "$machine"
  echo "-------------------------------------------------------------"
  restic -r "ak$machine/$machine" forget --prune --keep-last 10 --keep-weekly 10 --keep-monthly 8 --keep-yearly 5
done
chown www-data:www-data ak* -R
