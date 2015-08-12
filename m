From: eric@anholt.net (Eric Anholt)
Date: Wed, 12 Aug 2015 11:45:13 -0700
Subject: [GIT PULL] RPi SOC changes for v4.3
Message-ID: <87oaic8hxi.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following Lee's forwarding of the DT changes for the firmware driver for
4.3, here's the associated driver for the brcm arm-soc tree.

I think this is the first time RPi changes have been forwarded through
Florian.  It was suggested by Florian when I was discussing RPi
upstreaming with him and Arnd.  I think it makes sense, since general
-next trees for Broadcom are maintained there, and he's willing to
accept pull requests at any point.

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  http://github.com/anholt/linux tags/rpi-soc-for-4.3-v1

for you to fetch changes up to d39ae82e65dc538295eea0384ed1ad8752dabbae:

  ARM: bcm2835: Add the Raspberry Pi firmware driver (2015-08-11 11:27:13 -0700)

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
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150812/b876ccd9/attachment.sig>
