From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 12 Nov 2015 10:29:20 +0900
Subject: [PATCH v2 0/3] gose: Enable QSPI
Message-ID: <1447291763-27527-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this short series adds QSPI to the r8a7793 and gose device tree.
DMA is enabled for QSPI and accordingly DMAC nodes are also added
to the r8a7793 device tree.

Based on renesas-devel-20151112-v4.3.

Key Changes between v1 and v2:
* Move partitions into partitions subnode

Simon Horman (3):
  ARM: shmobile: r8a7793: Add DMAC devices to DT
  ARM: shmobile: r8a7793: Add QSPI device to DT
  ARM: shmobile: gose: Add QSPI device to DT

 arch/arm/boot/dts/r8a7793-gose.dts | 43 +++++++++++++++++
 arch/arm/boot/dts/r8a7793.dtsi     | 98 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 141 insertions(+)

-- 
2.1.4
