From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue,  2 Sep 2014 10:15:18 +0200
Subject: [PATCH V2 3/4] ARM: mvebu: add SSCG to Armada 370 Device Tree
In-Reply-To: <1409645719-20003-1-git-send-email-gregory.clement@free-electrons.com>
References: <1409645719-20003-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1409645719-20003-4-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 370 SoC has a Spread Spectrum Clock Generator. This commit
adds the description of this generator to the Device Tree describing
this SoC.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-370.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 21b588b6f6bd..dfbbb709f4fb 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -206,6 +206,10 @@
 				status = "okay";
 			};
 
+			sscg at 18330 {
+				reg = <0x18330 0x4>;
+			};
+
 			interrupt-controller at 20000 {
 				reg = <0x20a00 0x1d0>, <0x21870 0x58>;
 			};
-- 
1.9.1
