From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 23 Apr 2016 12:58:59 -0700
Subject: [GIT PULL 3/4] Broadcom defconfig changes for 4.7
In-Reply-To: <1461441540-5095-1-git-send-email-f.fainelli@gmail.com>
References: <1461441540-5095-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1461441540-5095-3-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.7/defconfig

for you to fetch changes up to b72541b33825807d247b6455364db9cd3ca5d6ad:

  Merge tag 'bcm2835-defconfig-next-2016-04-20' into defconfig/next (2016-04-22 12:25:34 -0700)

----------------------------------------------------------------
This pull request contains defconfig changes for Broadcom ARM-based SoCs:

- Eric enables more BCM2835 peripherals in multi_v7_defconfig: watchdog, I2S,
  switches from the sdhci-bcm2835 to the sdhci-iproc driver, DWC2 USB controller

- Eric also enables more BCM2835 peripherals in bcm2835_defconfig: VC4, NFS root
  Power Management support, switching sdhci-bcm2835 for sdhci-iproc

----------------------------------------------------------------
Eric Anholt (7):
      ARM: multi_v7_defconfig: Add more BCM2835 support
      ARM: multi_v7_defconfig: Switch BCM2835 to sdhci-iproc.c for MMC
      ARM: multi_v7_defconfig: Build in DWC2 USB support
      ARM: bcm2835: Switch BCM2835 to sdhci-iproc.c for MMC
      ARM: bcm2835: Enable CONFIG_PM.
      ARM: bcm2835: Enable the VC4 graphics driver in the defconfig
      ARM: bcm2835: Enable NFS root support.

Florian Fainelli (1):
      Merge tag 'bcm2835-defconfig-next-2016-04-20' into defconfig/next

 arch/arm/configs/bcm2835_defconfig  | 11 +++++++----
 arch/arm/configs/multi_v7_defconfig |  5 +++--
 2 files changed, 10 insertions(+), 6 deletions(-)
