From: monstr@monstr.eu (Michal Simek)
Date: Wed, 23 Apr 2014 08:11:15 +0200
Subject: [GIT PULL] serial: Cadence
Message-ID: <53575983.3030508@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

this is around for a while and I would like to close it.
I have applied patches 1-7 from v3.
Patches 8 and 9 should go through arm-soc tree and I will add them
to my zynq/dt branch.

Please apply these patches to your tree.
If this should go through different tree please let me know.

Thanks,
Michal


The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  git://git.monstr.eu/linux-2.6-microblaze.git tags/cadence-uart-for-3.16

for you to fetch changes up to 05a06a30d212f76e7822ef1093fa002baac021a7:

  tty: xuartps: Rebrand driver as Cadence UART (2014-04-23 08:00:10 +0200)

----------------------------------------------------------------
tty: Cadence uart rebranding and cleanup

----------------------------------------------------------------
Michal Simek (2):
      tty: xuartps: Fix kernel-doc errors in the driver
      tty: xuartps: Initialize ports according to aliases

Soren Brinkmann (5):
      tty: xuartps: Clean up
      tty: xuartps: Print warning in clock notifier
      tty: xuartps: Refactor read-modify-writes
      tty: xuartps: Don't write IRQ disable register to enable interrupts
      tty: xuartps: Rebrand driver as Cadence UART

 drivers/tty/serial/Kconfig         |    9 +-
 drivers/tty/serial/xilinx_uartps.c | 1129 +++++++++++++++++++++++++++++++++++--------------------------------------
 include/uapi/linux/serial_core.h   |    2 +-
 3 files changed, 546 insertions(+), 594 deletions(-)


-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140423/93e2adbf/attachment.sig>
