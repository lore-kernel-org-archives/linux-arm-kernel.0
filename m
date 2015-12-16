From: ulrich.hecht+renesas@gmail.com (Ulrich Hecht)
Date: Wed, 16 Dec 2015 11:34:21 +0100
Subject: [PATCH v2 2/2] arm64: dts: r8a7795: fix SATA clock assignment
In-Reply-To: <1450262061-1441-1-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1450262061-1441-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Message-ID: <1450262061-1441-3-git-send-email-ulrich.hecht+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SATA clock is 815, not 915.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 7d4707e..7b02281 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -977,7 +977,7 @@
 			compatible = "renesas,sata-r8a7795";
 			reg = <0 0xee300000 0 0x1fff>;
 			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 915>;
+			clocks = <&cpg CPG_MOD 815>;
 			status = "disabled";
 		};
 	};
-- 
2.6.3
