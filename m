From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 19 Oct 2015 11:43:09 -0700
Subject: [GIT PULL 2/2] Broadcom SoC changes for v4.4 (part 2)
Message-ID: <1445280190-8812-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c4a8ea9e0698945b182ba1e1063a0981b1f35139:

  ARM: brcmstb: Setup BIU control registers during boot (2015-10-09 13:42:18 -0700)

are available in the git repository at:

  http://github.com/Broadcom/stblinux tags/arm-soc/for-4.4/soc-part2

for you to fetch changes up to d0317a5d496dfac6d11e281d61b7aae0d4192e81:

  ARM: bcm2835: Add the Raspberry Pi firmware driver (2015-10-19 11:08:40 -0700)

----------------------------------------------------------------
This pull request contains the Raspberry Pi firmware driver, for communicating
with the VPU which has exclusive control of some of the peripherals.

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
