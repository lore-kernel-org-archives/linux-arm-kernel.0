From: eric@anholt.net (Eric Anholt)
Date: Tue, 21 Mar 2017 12:39:50 -0700
Subject: [GIT PULL 2/4] bcm2835 arm defconfig updates for 4.12
In-Reply-To: <20170321193952.10270-1-eric@anholt.net>
References: <20170321193952.10270-1-eric@anholt.net>
Message-ID: <20170321193952.10270-2-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://github.com/anholt/linux tags/bcm2835-defconfig-next-2017-03-21

for you to fetch changes up to 51a08de0fd3d1d25d28f99ef992cb429cced56a5:

  arm: set CONFIG_MMC_BCM2835=y in bcm2835_defconfig and multi_v7_defconfig (2017-03-17 16:58:12 -0700)

----------------------------------------------------------------
This pull request fixes graphics in bcm2835_defconfig by enabling CMA,
and starts building the new SDHOST MMC driver on multi_v7_defconfig,
so that we can switch to it by default in the following release.

----------------------------------------------------------------
Gerd Hoffmann (1):
      arm: set CONFIG_MMC_BCM2835=y in bcm2835_defconfig and multi_v7_defconfig

Stefan Wahren (1):
      ARM: bcm2835: Enable missing CMA settings for VC4 driver

 arch/arm/configs/bcm2835_defconfig  | 5 +++--
 arch/arm/configs/multi_v7_defconfig | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)
