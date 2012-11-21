From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 21 Nov 2012 23:24:29 +0100
Subject: [GIT PULL] Marvell OpenBlocks AX3-4: enable SATA and I2C
Message-ID: <1353536675-15010-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason,

Here is a rather late pull request, but it is only touching DT data
and mvebu_defconfig, in order to enable I2C and SATA on OpenBlocks
AX3-4.

Thanks!

The following changes since commit 74f980beaa660614c707675ce6a11e70db3d49b6:

  Merge tag 'marvell-net-xor-defconfig-for-3.8' of github.com:MISL-EBU-System-SW/mainline-public into test-the-merge (2012-11-20 23:42:09 +0100)

are available in the git repository at:

  git at github.com:MISL-EBU-System-SW/mainline-public.git tags/marvell-openblocks-i2c-sata-for-3.8

for you to fetch changes up to 9bfd143ed247fc7a9e0573dc1fbaf6d124b5cac9:

  ARM: mvebu: update defconfig with I2C and RTC support (2012-11-21 23:20:36 +0100)

----------------------------------------------------------------
Marvell SATA and I2C enabling for OpenBlocks AX3-4

----------------------------------------------------------------
Nobuhiro Iwamatsu (3):
      ARM: mvebu: Add support for I2C controllers in Armada 370/XP
      ARM: mvebu: Add support for I2C on OpenBlocks AX3-4
      ARM: mvebu: Add support for the RTC in OpenBlocks AX3-4

Thomas Petazzoni (2):
      ARM: mvebu: Add SATA support for OpenBlocks AX3-4
      ARM: mvebu: update defconfig with I2C and RTC support

 arch/arm/boot/dts/armada-370-xp.dtsi             |   22 ++++++++++++++++++++++
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts |   17 +++++++++++++++++
 arch/arm/configs/mvebu_defconfig                 |    4 ++++
 3 files changed, 43 insertions(+)
