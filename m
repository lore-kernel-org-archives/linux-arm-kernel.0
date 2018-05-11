From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 11 May 2018 14:43:34 -0700
Subject: [GIT PULL 1/5] Broadcom defconfig changes for 4.18
Message-ID: <20180511214339.24139-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  https://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.18/defconfig

for you to fetch changes up to f8928381021121123e9f4f783606c51cd37ab5d9:

  Merge tag 'bcm2835-defconfig-next-2018-04-30' into defconfig/next (2018-05-01 11:53:24 -0700)

----------------------------------------------------------------
This pull request contains Broadcom ARM-based SoCs defconfig changes for
4.18, please pull the following:

- Stefan provides a set of updates targeting the Raspberry Pi 3 B+
  platform: LAN7515 USB Ethernet driver, Cypress CYW43455 Bluetooth and
  he also enables the VCHIQ driver to help with continous testing on
  kernelci.org.

----------------------------------------------------------------
Florian Fainelli (1):
      Merge tag 'bcm2835-defconfig-next-2018-04-30' into defconfig/next

Stefan Wahren (3):
      ARM: bcm2835_defconfig: Enable LAN78XX driver
      ARM: bcm2835_defconfig: Enable VCHIQ driver
      ARM: multi_v7_defconfig: Enable LAN and BT for RPi 3 B+

 arch/arm/configs/bcm2835_defconfig  | 2 ++
 arch/arm/configs/multi_v7_defconfig | 4 ++++
 2 files changed, 6 insertions(+)
