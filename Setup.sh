# persistent ssd
sudo mkfs.ext4 -m 0 -E lazy_itable_init=0,lazy_journal_init=0,discard /dev/sdb
sudo mkdir -p /mnt/disks/ssd
sudo mount -o discard,defaults /dev/sdb /mnt/disks/ssd
sudo chmod a+w /mnt/disks/ssd

# DuckDB
sudo apt install python3-pip --no-install-recommends -y
pip install duckdb==0.7.1
