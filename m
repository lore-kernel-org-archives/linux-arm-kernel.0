From: eric@anholt.net (Eric Anholt)
Date: Mon, 30 Apr 2018 14:27:49 -0700
Subject: [GIT PULL 2/3] bcm2835-defconfig-next-2018-04-30
In-Reply-To: <20180430212750.12303-1-eric@anholt.net>
References: <20180430212750.12303-1-eric@anholt.net>
Message-ID: <20180430212750.12303-2-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://github.com/anholt/linux tags/bcm2835-defconfig-next-2018-04-30

for you to fetch changes up to 329fb2b79b132d727dd8a1624da8dc5331eb8633:

  ARM: multi_v7_defconfig: Enable LAN and BT for RPi 3 B+ (2018-04-23 13:25:49 -0700)

----------------------------------------------------------------
This pull request enables recent new drivers for the Raspberry Pi, including
the networking on the Pi 3 B+.

----------------------------------------------------------------
Stefan Wahren (3):
      ARM: bcm2835_defconfig: Enable LAN78XX driver
      ARM: bcm2835_defconfig: Enable VCHIQ driver
      ARM: multi_v7_defconfig: Enable LAN and BT for RPi 3 B+

 arch/arm/configs/bcm2835_defconfig  | 2 ++
 arch/arm/configs/multi_v7_defconfig | 4 ++++
 2 files changed, 6 insertions(+)
