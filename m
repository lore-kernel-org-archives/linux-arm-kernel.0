From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 18 Jul 2018 17:27:13 +0200
Subject: [GIT PULL] ARM: mvebu: defconfig for v4.19 (#1)
Message-ID: <87y3e88sz2.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for defconfig for mvebu for v4.19.

Gregory

The following changes since commit 021c91791a5e7e85c567452f1be3e4c2c6cb6063:

  Linux 4.18-rc3 (2018-07-01 16:04:53 -0700)

are available in the Git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-defconfig-4.19-1

for you to fetch changes up to b4645695a9dca5bbdcb9d6133731d661d2a3c4fb:

  ARM: mvebu_v7_defconfig: enable SFP support (2018-07-18 17:07:05 +0200)

----------------------------------------------------------------
mvebu defconfig for 4.19 (part 1)

 - add NAND controller on multi_v7
 - add SFP support on mvebu_v7

----------------------------------------------------------------
Baruch Siach (2):
      ARM: mvebu_v7_defconfig: sync defconfig
      ARM: mvebu_v7_defconfig: enable SFP support

Gregory CLEMENT (1):
      ARM: multi_v7_defconfig: Add Marvell NAND controller support

 arch/arm/configs/multi_v7_defconfig |  1 +
 arch/arm/configs/mvebu_v7_defconfig | 13 +++----------
 2 files changed, 4 insertions(+), 10 deletions(-)
