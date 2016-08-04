From: jaz@semihalf.com (Grzegorz Jaszczyk)
Date: Thu,  4 Aug 2016 12:14:08 +0200
Subject: [PATCH v2 05/17] ARM: dts: mvebu: armada-390: add missing
 compatibility string and bracket
In-Reply-To: <1470305660-6601-1-git-send-email-jaz@semihalf.com>
References: <1470305660-6601-1-git-send-email-jaz@semihalf.com>
Message-ID: <1470305660-6601-6-git-send-email-jaz@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The armada-390.dtsi was broken since the first patch which adds Device Tree
files for Armada 39x SoC was introduced.

Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: <stable@vger.kernel.org> # 4.0+
Fixes 538da83 ("ARM: mvebu: add Device Tree files for Armada 39x SoC and board")
---
 arch/arm/boot/dts/armada-390.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/armada-390.dtsi b/arch/arm/boot/dts/armada-390.dtsi
index 094e39c..6cd18d8 100644
--- a/arch/arm/boot/dts/armada-390.dtsi
+++ b/arch/arm/boot/dts/armada-390.dtsi
@@ -47,6 +47,8 @@
 #include "armada-39x.dtsi"
 
 / {
+	compatible = "marvell,armada390";
+
 	soc {
 		internal-regs {
 			pinctrl at 18000 {
@@ -54,4 +56,5 @@
 				reg = <0x18000 0x20>;
 			};
 		};
+	};
 };
-- 
1.8.3.1
