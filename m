From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  9 Nov 2015 10:33:17 +0900
Subject: [PATCH 0/2]  ARM: shmobile: r8a7793: Add PFC to DT
Message-ID: <1447032799-13155-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This short series adds PFC support to the r8a7793 and its gose board.

The PFC driver is already present and is the same driver as the r8a7791.

Simon Horman (2):
  ARM: shmobile: r8a7793: Add PFC to DT
  ARM: shmobile: gose: Configure PFC in DT

 arch/arm/boot/dts/r8a7793-gose.dts | 31 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/r8a7793.dtsi     |  6 ++++++
 2 files changed, 37 insertions(+)

-- 
2.1.4
