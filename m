From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 16 Nov 2012 10:32:35 +0100
Subject: [GIT PULL] Marvell board changes for 3.8, network related
Message-ID: <1353058359-28102-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Jason,

Here is a pull request that should be pulled on top of the previous
"[GIT PULL] Marvell board changes for the v3.8 merge window" that I
sent on November, 14th. It adds support for the network interfaces on
Armada 370/XP evaluation boards, on the OpenBlocks and Mirabox.

Thanks!

The following changes since commit e3e37bcab910a68616bc33145ed5c333825053ac:

  arm: mvebu: support for the Globalscale Mirabox board (2012-11-14 16:32:29 +0100)

are available in the git repository at:

  git at github.com:MISL-EBU-System-SW/mainline-public.git tags/marvell-boards-net-for-3.8

for you to fetch changes up to 9f32cccc67590ccda30529bcbcea5c22d95c00a6:

  arm: mvebu: enable Ethernet controllers on Mirabox platform (2012-11-16 10:17:48 +0100)

----------------------------------------------------------------
Marvell boards changes related to Ethernet, for 3.8

----------------------------------------------------------------
Thomas Petazzoni (4):
      arm: mvebu: add Ethernet controllers using mvneta driver for Armada 370/XP
      arm: mvebu: enable Ethernet controllers on Armada 370/XP eval boards
      arm: mvebu: enable Ethernet controllers on OpenBlocks AX3-4 platform
      arm: mvebu: enable Ethernet controllers on Mirabox platform

 arch/arm/boot/dts/armada-370-db.dts              |   23 ++++++++++++
 arch/arm/boot/dts/armada-370-mirabox.dts         |   21 +++++++++++
 arch/arm/boot/dts/armada-370-xp.dtsi             |   21 +++++++++++
 arch/arm/boot/dts/armada-xp-db.dts               |   43 ++++++++++++++++++++++
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts |   43 ++++++++++++++++++++++
 arch/arm/boot/dts/armada-xp.dtsi                 |   14 +++++++
 6 files changed, 165 insertions(+)
