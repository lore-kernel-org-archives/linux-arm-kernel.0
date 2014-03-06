From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  6 Mar 2014 13:44:33 +0900
Subject: [PATCH 5/7] ARM: shmobile: r8a7791: fix clock index for i2c5
In-Reply-To: <cover.1394080829.git.horms+renesas@verge.net.au>
References: <cover.1394080829.git.horms+renesas@verge.net.au>
Message-ID: <1f662dde5c287c33da84d4aaaec8a75f2aab8ee7.1394080829.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 45c369d..0852734 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -743,7 +743,7 @@
 			#clock-cells = <1>;
 			renesas,clock-indices = <
 				R8A7791_CLK_RCAN1 R8A7791_CLK_RCAN0 R8A7791_CLK_QSPI_MOD
-				R8A7791_CLK_I2C4 R8A7791_CLK_I2C4 R8A7791_CLK_I2C3
+				R8A7791_CLK_I2C5 R8A7791_CLK_I2C4 R8A7791_CLK_I2C3
 				R8A7791_CLK_I2C2 R8A7791_CLK_I2C1 R8A7791_CLK_I2C0
 			>;
 			clock-output-names =
-- 
1.8.5.2
