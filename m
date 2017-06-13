From: eric@anholt.net (Eric Anholt)
Date: Tue, 13 Jun 2017 10:43:53 -0700
Subject: [GIT PULL 1/4] bcm2835-defconfig-next-2017-06-12
Message-ID: <20170613174356.22426-1-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://github.com/anholt/linux tags/bcm2835-defconfig-next-2017-06-12

for you to fetch changes up to 3e9aaaf1d814586404dc93461ec955dd90dc8934:

  ARM: bcm2835_defconfig: Enable serial & ethernet USB gadget support (2017-06-12 14:07:38 -0700)

----------------------------------------------------------------
This pull request enables USB OTG mode in the Pi 0/1 defconfig.

----------------------------------------------------------------
Stefan Wahren (1):
      ARM: bcm2835_defconfig: Enable serial & ethernet USB gadget support

 arch/arm/configs/bcm2835_defconfig | 8 ++++++++
 1 file changed, 8 insertions(+)
