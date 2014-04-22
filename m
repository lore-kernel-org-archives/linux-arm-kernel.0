From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 22 Apr 2014 23:26:22 +0200
Subject: [PATCH v2 18/38] ARM: orion5x: rename XOR node to
 dma-controller@<address>
In-Reply-To: <1398202002-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1398202002-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1398202002-28530-19-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit renames the XOR engine Device Tree node to
dma-controller@, to conform with the standard node name proposed by
the ePAPR.

Suggested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/orion5x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/orion5x.dtsi b/arch/arm/boot/dts/orion5x.dtsi
index aef5d17..3802d4f 100644
--- a/arch/arm/boot/dts/orion5x.dtsi
+++ b/arch/arm/boot/dts/orion5x.dtsi
@@ -98,7 +98,7 @@
 				status = "disabled";
 			};
 
-			xor: xor at 60900 {
+			xor: dma-controller at 60900 {
 				compatible = "marvell,orion-xor";
 				reg = <0x60900 0x100
 				       0x60b00 0x100>;
-- 
1.9.2
