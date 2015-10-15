From: eric@anholt.net (Eric Anholt)
Date: Thu, 15 Oct 2015 11:54:43 -0700
Subject: [GIT PULL] SOC changes for BCM2835 for 4.4
Message-ID: <87mvvkotcc.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  http://github.com/anholt/linux tags/bcm2835-soc-for-4.4-v1

for you to fetch changes up to 4e3d60656a7235b6b6e86d7ef48b0394276c35b5:

  ARM: bcm2835: Add the Raspberry Pi firmware driver (2015-10-14 15:30:06 -0700)

----------------------------------------------------------------
This pull request contains the Raspberry Pi firmware driver, for
communicating with the VPU which has exclusive control of some of the
peripherals.

----------------------------------------------------------------
Eric Anholt (1):
      ARM: bcm2835: Add the Raspberry Pi firmware driver

 drivers/firmware/Kconfig                   |   7 +
 drivers/firmware/Makefile                  |   1 +
 drivers/firmware/raspberrypi.c             | 260 +++++++++++++++++++++++++++++
 include/soc/bcm2835/raspberrypi-firmware.h | 115 +++++++++++++
 4 files changed, 383 insertions(+)
 create mode 100644 drivers/firmware/raspberrypi.c
 create mode 100644 include/soc/bcm2835/raspberrypi-firmware.h
[ signature.asc: application/pgp-signature ]
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151015/6d4383ff/attachment.sig>
