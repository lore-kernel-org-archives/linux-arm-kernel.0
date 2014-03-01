From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 1 Mar 2014 00:41:53 -0500
Subject: [GIT PULL] ARM: mvebu: defconfig changes for v3.15 (incr. pull #2)
Message-ID: <20140301054153.GT1872@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All,

Nothing exciting here.  It's been in -next for a while.

This is an incremental pull request from tags/mvebu-defconfig-3.15 from
branch mvebu/defconfig up to tags/mvebu-defconfig-3.15-2.

Please pull.

thx,

Jason.

The following changes since commit dd1d03afe8a0825d718f5d74225ad57978599a89:

  ARM: mvebu: update defconfigs for Armada 375 and 38x (2014-02-17 22:48:39 +0000)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-defconfig-3.15-2

for you to fetch changes up to 7c8f827f57ad1a7f52e1679ded1b99d8a0c881ad:

  ARM: kirkwood: Add HP T5325 devices to {multi|mvebu}_v5_defconfig (2014-02-25 20:31:11 +0000)

----------------------------------------------------------------
mvebu defconfig changes for v3.15 (incremental pull #2)

 - add multi_v5_defconfig
 - add mvebu_v5_defconfig
 - kirkwood: add HP T5325 devices

----------------------------------------------------------------
Andrew Lunn (3):
      ARM: config: Add a multi_v5_defconfig
      ARM: config: Add mvebu_v5_defconfig
      ARM: kirkwood: Add HP T5325 devices to {multi|mvebu}_v5_defconfig

 arch/arm/configs/multi_v5_defconfig | 194 ++++++++++++++++++++++++++++++++++++
 arch/arm/configs/mvebu_v5_defconfig | 181 +++++++++++++++++++++++++++++++++
 2 files changed, 375 insertions(+)
 create mode 100644 arch/arm/configs/multi_v5_defconfig
 create mode 100644 arch/arm/configs/mvebu_v5_defconfig
