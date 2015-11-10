From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 10 Nov 2015 16:13:58 +0900
Subject: [PATCH 0/3] gose: Enable QSPI
Message-ID: <1447139641-11480-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this short series adds QSPI to the r8a7793 and gose device tree.
DMA is enabled for QSPI and accordingly DMAC nodes are also added
to the r8a7793 device tree.

Based on renesas-devel-20151110-v4.3.

Simon Horman (3):
  ARM: shmobile: r8a7793: Add DMAC devices to DT
  ARM: shmobile: r8a7793: Add QSPI device to DT
  ARM: shmobile: gose: Add QSPI device to DT

 arch/arm/boot/dts/r8a7793-gose.dts | 40 ++++++++++++++++
 arch/arm/boot/dts/r8a7793.dtsi     | 98 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 138 insertions(+)

-- 
2.1.4
