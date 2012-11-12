From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 12 Nov 2012 18:20:33 +0100
Subject: arm: mvebu: Pull request for 'marvell-boards' branch
Message-ID: <1352740839-13586-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason, Andrew,

The following changes since commit 77b67063bb6bce6d475e910d3b886a606d0d91f7:

  Linux 3.7-rc5 (2012-11-11 13:44:33 +0100)

are available in the git repository at:

  git at github.com:MISL-EBU-System-SW/mainline-public.git marvell-boards

for you to fetch changes up to 39325a96e1d082bf71b7a4d9ac2d5806f80c6d13:

  arm: mvebu: add LED support in defconfig (2012-11-12 18:13:41 +0100)

----------------------------------------------------------------
Gregory CLEMENT (1):
      arm: mvebu: support for the Globalscale Mirabox board

Thomas Petazzoni (5):
      arm: mvebu: fix compatible string in armada-370-xp.dtsi
      arm: mvebu: don't list all boards in dt compat field for Armada 370/XP
      arm: mvebu: fix typo in machine name for Armada 370/XP
      arm: mvebu: support for the PlatHome OpenBlocks AX3-4 board
      arm: mvebu: add LED support in defconfig

 arch/arm/boot/dts/Makefile                       |    4 +-
 arch/arm/boot/dts/armada-370-mirabox.dts         |   37 ++++++++++++
 arch/arm/boot/dts/armada-370-xp.dtsi             |    2 +-
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts |   69 ++++++++++++++++++++++
 arch/arm/configs/mvebu_defconfig                 |    5 ++
 arch/arm/mach-mvebu/armada-370-xp.c              |    9 ++-
 6 files changed, 119 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/boot/dts/armada-370-mirabox.dts
 create mode 100644 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
