From: eric@anholt.net (Eric Anholt)
Date: Tue,  3 Jul 2018 13:05:10 -0700
Subject: [GIT PULL 3/4] bcm2835-defconfig-next-2018-07-03
In-Reply-To: <20180703200511.2725-1-eric@anholt.net>
References: <20180703200511.2725-1-eric@anholt.net>
Message-ID: <20180703200511.2725-3-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://github.com/anholt/linux tags/bcm2835-defconfig-next-2018-07-03

for you to fetch changes up to 7b54aafff3ef4571567ff6a7d13ed51554f07a71:

  ARM: multi_v7_defconfig: Enable RPi voltage sensor (2018-06-21 17:29:51 -0700)

----------------------------------------------------------------
This pull request enables the new RPi HWMON driver in the 32-bit
defconfigs.

----------------------------------------------------------------
Stefan Wahren (2):
      ARM: bcm2835_defconfig: Enable RPi voltage sensor
      ARM: multi_v7_defconfig: Enable RPi voltage sensor

 arch/arm/configs/bcm2835_defconfig  | 2 +-
 arch/arm/configs/multi_v7_defconfig | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)
