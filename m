From: eric@anholt.net (Eric Anholt)
Date: Tue, 21 Mar 2017 12:39:51 -0700
Subject: [GIT PULL 1/4] bcm2835 arm64 defconfig updates for 4.12
In-Reply-To: <20170321193952.10270-1-eric@anholt.net>
References: <20170321193952.10270-1-eric@anholt.net>
Message-ID: <20170321193952.10270-3-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://github.com/anholt/linux tags/bcm2835-defconfig-64-next-2017-03-21

for you to fetch changes up to 3c9d36192802d60fca73c85c7096221371c36be7:

  arm64: set CONFIG_MMC_BCM2835=y in defconfig (2017-03-17 17:02:52 -0700)

----------------------------------------------------------------
This pull request starts building the new SDHOST MMC driver on
multi_v7_defconfig, so that we can switch to it by default in the
following release.

----------------------------------------------------------------
Gerd Hoffmann (1):
      arm64: set CONFIG_MMC_BCM2835=y in defconfig

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)
