From: eric@anholt.net (Eric Anholt)
Date: Mon, 30 Apr 2018 14:27:50 -0700
Subject: [GIT PULL 3/3] bcm2835-defconfig-64-next-2018-04-30
In-Reply-To: <20180430212750.12303-1-eric@anholt.net>
References: <20180430212750.12303-1-eric@anholt.net>
Message-ID: <20180430212750.12303-3-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://github.com/anholt/linux tags/bcm2835-defconfig-64-next-2018-04-30

for you to fetch changes up to 69bc5b2c056b4e784b49a8c9c5049561b62352f7:

  arm64: defconfig: Enable LAN and BT support for RPi 3 B+ (2018-04-23 13:28:33 -0700)

----------------------------------------------------------------
This pull request enables the Raspberry Pi 3 B+'s LAN and bluetooth in
the arm64 defconfig.

----------------------------------------------------------------
Stefan Wahren (1):
      arm64: defconfig: Enable LAN and BT support for RPi 3 B+

 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)
