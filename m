From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 14 Nov 2012 16:47:00 +0100
Subject: [GIT PULL] Marvell board changes for the v3.8 merge window
Message-ID: <1352908022-32628-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 77b67063bb6bce6d475e910d3b886a606d0d91f7:

  Linux 3.7-rc5 (2012-11-11 13:44:33 +0100)

are available in the git repository at:

  git at github.com:MISL-EBU-System-SW/mainline-public.git tags/marvell-boards-for-3.8

for you to fetch changes up to e3e37bcab910a68616bc33145ed5c333825053ac:

  arm: mvebu: support for the Globalscale Mirabox board (2012-11-14 16:32:29 +0100)

----------------------------------------------------------------
Marvell boards changes for 3.8

----------------------------------------------------------------
Gregory CLEMENT (1):
      arm: mvebu: support for the Globalscale Mirabox board

Thomas Petazzoni (1):
      arm: mvebu: support for the PlatHome OpenBlocks AX3-4 board

 arch/arm/boot/dts/Makefile                       |    4 +-
 arch/arm/boot/dts/armada-370-mirabox.dts         |   37 ++++++++++++
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts |   69 ++++++++++++++++++++++
 3 files changed, 109 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/armada-370-mirabox.dts
 create mode 100644 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
