From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 26 Aug 2016 15:49:38 +0200
Subject: [PATCH 1/4] ARM: dts: shmobile: remove label property from led
Message-ID: <1472219382-22789-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove label property from led nodes. This seems to have little
value and is used inconsistently amongst Renesas SoCs.

Based on renesas-devel-20160824-v4.8-rc3

Simon Horman (4):
  ARM: dts: armadillo800eva: remove label property from led nodes
  ARM: dts: koelsch: remove label property from led nodes
  ARM: dts: gose: remove label property from led nodes
  ARM: dts: kzm9g: remove label property from led nodes

 arch/arm/boot/dts/r8a7740-armadillo800eva.dts | 4 ----
 arch/arm/boot/dts/r8a7791-koelsch.dts         | 3 ---
 arch/arm/boot/dts/r8a7793-gose.dts            | 3 ---
 arch/arm/boot/dts/sh73a0-kzm9g.dts            | 4 ----
 4 files changed, 14 deletions(-)

-- 
2.7.0.rc3.207.g0ac5344
