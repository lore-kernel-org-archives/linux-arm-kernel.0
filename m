From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 20 Feb 2016 11:46:26 -0800
Subject: [GIT PULL 7/8] Broadcom defconfig changes for 4.6
In-Reply-To: <1455997587-17564-1-git-send-email-f.fainelli@gmail.com>
References: <1455997587-17564-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1455997587-17564-7-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.6/defconfig

for you to fetch changes up to 9eefbe52737f2ae6c2d3556339ef851201516c26:

  Merge tag 'bcm2835-defconfig-next-2016-02-17' into defconfig/next (2016-02-20 11:07:10 -0800)

----------------------------------------------------------------
This pull request contains defconfig changes for Broadcom ARM-based SoCs:

- Daniel enables all that is required to get the BCM283x (Raspberry Pi and
  Raspberry Pi 2) SoCs to boot with multi_v7_defconfig

- Stefan enables the Raspberry Pi firmware driver and power domain drivers
  in bcm2835_defconfig

- Stephen refreshes the bcm2835_defconfig, disables DEBUG_LL, and turns on
  ARMv7 support which is needed for BCM2836 (Raspberry Pi 2)

----------------------------------------------------------------
Daniel Stone (1):
      ARM: multi_v7_defconfig: Enable BCM283x

Florian Fainelli (1):
      Merge tag 'bcm2835-defconfig-next-2016-02-17' into defconfig/next

Stefan Wahren (2):
      ARM: bcm2835_defconfig: Enable RPi firmware driver
      ARM: bcm2835_defconfig: Enable RPi power domain driver

Stephen Warren (3):
      ARM: bcm2835_defconfig: rebuild on next-20160205
      ARM: bcm2835_defconfig: disable DEBUG_LL
      ARM: bcm2835_defconfig: enable ARMv7 support

 arch/arm/configs/bcm2835_defconfig  | 11 +++++------
 arch/arm/configs/multi_v7_defconfig | 12 ++++++++++++
 2 files changed, 17 insertions(+), 6 deletions(-)
