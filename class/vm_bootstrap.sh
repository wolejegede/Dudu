apt update && apt install -y && apt upgrade -y
adduser osscontrol --disabled-password
echo "osscontrol ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers
mkdir -m 700 /home/osscontrol/.ssh
# update key for if you are deploying to different dc/env
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCfU/wblrXyvLOOSZ5p6QU0MGLka8tqdm72Wh6KOBcjcIKAcGJgtq5sEuD3jV5WyyUI4VTDRJUeUaKdWR/CGvcLoXaDlR/0YdjvsCIgkra9uaOfXjNrwrkgewDj++DcIixfe6v2GJiNf0016CygFmSEmr6kJSlN7HdNopfR5WhPb6ggw0o5Z4mctucvL8R4XnoWQradNuHGlgPelS4G2cy1bHSzGivZsoT2nxIQaoeTpHWXI913OVGfMfBybKrpwu/2ohx5nus2GjxT0LZ3Q0fo7U0flsXdSyLWyfRRgT9lD+2EV4tpwgeMxbQ0bkEEWIC8zkFVd21LX4JUEHaHXtxv root@compute-controllerdal1201' > /home/osscontrol/.ssh/authorized_keys
chown osscontrol:osscontrol /home/osscontrol/.ssh
chown osscontrol:osscontrol /home/osscontrol/.ssh/authorized_keys
chmod 400 /home/osscontrol/.ssh/authorized_keys
shutdown -r now
