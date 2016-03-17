From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Mar 2016 16:33:09 +0900
Subject: [PATCH 0/2] ARM: dts: r8a7794: Add IIC nodes
Message-ID: <1458199991-19391-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this short series adds IIC nodes to the r8a7794 device tree.

It is unclear to me how these devices may be tested given
the boards currently available for the r8a7794 SoC.

Based on renesas-devel-20160317-v4.5


Simon Horman (2):
  ARM: dts: r8a7794: add IIC clocks
  ARM: dts: r8a7794: Add IIC nodes

 arch/arm/boot/dts/r8a7794.dtsi            | 37 ++++++++++++++++++++++++++++---
 include/dt-bindings/clock/r8a7794-clock.h |  2 ++
 2 files changed, 36 insertions(+), 3 deletions(-)

-- 
2.1.4
