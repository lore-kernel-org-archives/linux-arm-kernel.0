From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 16 Nov 2015 19:37:49 +0800
Subject: [PATCH] arm64: dts: berlin: PSCI-1.0 support
Message-ID: <1447673869-842-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The firmware can support PSCI-1.0 in fact. This change also enables
suspend to ram on Marvell berlin arm64 SoC.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm64/boot/dts/marvell/berlin4ct.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi b/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
index 8eddf10..a87f1a2 100644
--- a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
+++ b/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
@@ -55,7 +55,7 @@
 	};
 
 	psci {
-		compatible = "arm,psci-0.2";
+		compatible = "arm,psci-1.0", "arm,psci-0.2";
 		method = "smc";
 	};
 
-- 
2.6.2
