From: eric@anholt.net (Eric Anholt)
Date: Wed, 17 Feb 2016 18:56:47 -0800
Subject: [GIT PULL 1/2] bcm2835 changes to defconfigs for 4.6
Message-ID: <1455764208-5679-1-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git at github.com:anholt/linux.git bcm2835-defconfig-next-2016-02-17

for you to fetch changes up to 0a05d3b71ada526ef93019fb3fbd6a95561a8a5f:

  ARM: multi_v7_defconfig: Enable BCM283x (2016-02-17 11:18:05 -0800)

----------------------------------------------------------------
This pull request brings in defconfig changes to enable bcm2836 in the
2835 and multi_v7 defconfigs.

----------------------------------------------------------------
Daniel Stone (1):
      ARM: multi_v7_defconfig: Enable BCM283x

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
