From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  4 Mar 2014 17:36:58 +0100
Subject: [PATCH 0/4] ARM: mvebu: Device Tree updates for Armada XP boards
Message-ID: <1393951022-18114-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This set of commits updates the Armada XP DB and Armada XP GP Device
Trees to work with the newest DT capable bootloaders from Marvell that
remap internal registers at 0xf1000000 and move the MBus Window base
address to 0xf0000000.

Also, the last commit updates the available amount of RAM on the
Armada XP Matrix board.

Thomas

Thomas Petazzoni (4):
  ARM: mvebu: change the default PCIe apertures for Armada 370/XP
  ARM: mvebu: switch the Armada XP DB to use internal registers at
    0xf1000000
  ARM: mvebu: switch the Armada XP GP to use internal registers at
    0xf1000000
  ARM: mvebu: the Armada XP Matrix board has 4 GB

 arch/arm/boot/dts/armada-370-xp.dtsi   |  4 ++--
 arch/arm/boot/dts/armada-xp-db.dts     | 13 +++++++++++--
 arch/arm/boot/dts/armada-xp-gp.dts     | 22 ++++++++++++++++------
 arch/arm/boot/dts/armada-xp-matrix.dts |  7 ++++++-
 4 files changed, 35 insertions(+), 11 deletions(-)

-- 
1.8.3.2
