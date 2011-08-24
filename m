From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 24 Aug 2011 17:30:54 -0300
Subject: MX53Loco reports half of the total memory
Message-ID: <CAOMZO5C6gaJUD3RTCwGqDhcojx3Thww22c+tsdC4bvTUmiSw6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On a mx53loco board U-boot reports 1GB of total available memory:


U-Boot 2011.06-04814-geee1e2f (Aug 22 2011 - 13:37:53)

CPU:   Freescale i.MX53 family rev2.1 at 800 MHz
Reset cause: POR
Board: MX53 LOCO
DRAM:  1 GiB
MMC:   FSL_ESDHC: 0, FSL_ESDHC: 1
In:    serial
Out:   serial
Err:   serial
Net:   got MAC address from fuse: 00:04:9f:01:c6:57
FEC
Hit any key to stop autoboot:  0
MX53LOCO U-Boot >

When booting 3.1-rc3 only 512MB is reported:
...
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 512MB = 512MB total
Memory: 515420k/515420k available, 8868k reserved, 0K highmem
Virtual kernel memory layout:
...

Shouldn't the kernel report the whole 1GB?

Regards,

Fabio Estevam
