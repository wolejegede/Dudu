#! /bin/sh

OPTIONS="attr2,inode64,largeio,logbufs=8,noatime,nobarrier,nodiratime,noquota,rw"
XFS_OPTS="-l internal,size=128m,lazy-count=1 -i size=512"

DISKS="${*}"
if [ -z "${DISKS}" ] ; then
  DISKS=`ls /dev/sd[b-z] /dev/sda[a-z] 2>/dev/null`
fi

for DISK in ${DISKS} ; do
  if ! echo "${DISK}" | grep -q '^/dev/' ; then
    DISK="/dev/${DISK}"
  fi
  /sbin/sgdisk -Z ${DISK}
  /sbin/sgdisk --clear ${DISK}
  /sbin/sgdisk -N 1 ${DISK}
  /sbin/mkfs.xfs ${XFS_OPTS} -f ${DISK}1
  UUID=`/sbin/blkid | grep "${DISK}1" | awk '{print $2}' | awk -F= '{print $2}' | sed 's/"//g'`
  DISK=`echo "${DISK}" | awk -F'/' '{print $3}'`
  MOUNT="/srv/elasticsearch/${DISK}"
  mkdir -p "${MOUNT}"
  chmod 0750 "${MOUNT}"
  echo "UUID=${UUID}    ${MOUNT}      xfs     ${OPTIONS}  0 2" >> /etc/fstab
  mount "${MOUNT}"
  chmod 0750 "${MOUNT}"
done

chmod 0750 /srv/elasticsearch
