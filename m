From: eric@anholt.net (Eric Anholt)
Date: Wed, 20 Apr 2016 13:27:47 -0700
Subject: [GIT PULL 2/2] bcm2835 defconfig changes for 4.7
In-Reply-To: <1461184067-31925-1-git-send-email-eric@anholt.net>
References: <1461184067-31925-1-git-send-email-eric@anholt.net>
Message-ID: <1461184067-31925-2-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  https://github.com/anholt/linux tags/bcm2835-defconfig-next-2016-04-20

for you to fetch changes up to 3652bb35abf6ee11333cbec1d2855c1c0f9f6b27:

  ARM: bcm2835: Enable NFS root support. (2016-04-04 11:03:30 -0700)

----------------------------------------------------------------
This pull request brings in changes for bcm2835_defconfig and
multi_v7_defconfig in 4.7.

----------------------------------------------------------------
Eric Anholt (7):
      ARM: multi_v7_defconfig: Add more BCM2835 support
      ARM: multi_v7_defconfig: Switch BCM2835 to sdhci-iproc.c for MMC
      ARM: multi_v7_defconfig: Build in DWC2 USB support
      ARM: bcm2835: Switch BCM2835 to sdhci-iproc.c for MMC
      ARM: bcm2835: Enable CONFIG_PM.
      ARM: bcm2835: Enable the VC4 graphics driver in the defconfig
      ARM: bcm2835: Enable NFS root support.

 arch/arm/configs/bcm2835_defconfig  | 11 +++++++----
 arch/arm/configs/multi_v7_defconfig |  5 +++--
 2 files changed, 10 insertions(+), 6 deletions(-)
