From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 20 Nov 2012 15:57:01 +0100
Subject: [GIT PULL v3] Adding SATA support for Armada 370/XP
Message-ID: <1353423425-20574-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason,

Here is a pull request of SATA support patches for Armada 370/XP. It
depends on the clk series of patches, and replace the previous SATA
patches you had.

Changes since v2:
 * Use the proper gating clocks as SATA clocks;
 * Use tabs instead of spaces in the .dtsi/.dts files
 * Slightly reword the title of patch 2, 3, 4

Thanks!

The following changes since commit 1611f872513735ac7105535689c0dd668fbf1c04:

  ARM: Kirkwood: switch to DT clock providers (2012-11-20 14:46:50 +0100)

are available in the git repository at:

  git at github.com:MISL-EBU-System-SW/mainline-public.git tags/marvell-sata-3.8

for you to fetch changes up to 3d82daaaa6c7b91a534a54c7d123fe419155bf98:

  arm: mvebu: SATA support: board-level DT data for Armada 370/XP boards (2012-11-20 15:42:07 +0100)

----------------------------------------------------------------
Marvell Armada 370/XP support for 3.8

----------------------------------------------------------------
Gregory CLEMENT (4):
      arm: mvebu: increase atomic coherent pool size for armada 370/XP
      arm: mvebu: SATA support: SoC-level DT data for Armada 370/XP
      arm: mvebu: SATA support: mvebu_defconfig update
      arm: mvebu: SATA support: board-level DT data for Armada 370/XP boards

 arch/arm/boot/dts/armada-370-db.dts  |    4 ++++
 arch/arm/boot/dts/armada-370-xp.dtsi |   10 ++++++++++
 arch/arm/boot/dts/armada-xp-db.dts   |    4 ++++
 arch/arm/configs/multi_v7_defconfig  |    2 ++
 arch/arm/configs/mvebu_defconfig     |    3 +++
 arch/arm/mach-mvebu/armada-370-xp.c  |   12 ++++++++++++
 6 files changed, 35 insertions(+)
