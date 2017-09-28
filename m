From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 28 Sep 2017 14:45:48 +0200
Subject: [PATCH 0/2] arm64: dts: marvell: PCIe related fixes for Armada 7K/8K
Message-ID: <20170928124550.11492-1-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Here are two patches doing exactly the same fix, one for the master
CP110 and one for the slave CP110. The only reason for splitting the
fix into two patches is that the "Fixes:" tag is different in the two
patches. Indeed, the CP110 master DT and the CP110 slave DT were
introduced at different times (master CP110 in Linux 4.7, slave CP110
in Linux 4.9).

Thanks!

Thomas

Thomas Petazzoni (2):
  arm64: dts: marvell: fix interrupt-map property for Armada CP110
    master PCIe controller
  arm64: dts: marvell: fix interrupt-map property for Armada CP110 slave
    PCIe controller

 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi | 6 +++---
 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi  | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.13.5
