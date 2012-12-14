From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Fri, 14 Dec 2012 17:45:25 +0100
Subject: [PATCH 1/7] ARM: sh7372: add missing "#interrupt-cells" properties
In-Reply-To: <1355503531-7276-1-git-send-email-g.liakhovetski@gmx.de>
References: <1355503531-7276-1-git-send-email-g.liakhovetski@gmx.de>
Message-ID: <1355503531-7276-2-git-send-email-g.liakhovetski@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two of four interrupt controllers in sh7372.dtsi are missing the compulsory
"#interrupt-cells" properties. Fix this.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/boot/dts/sh7372.dtsi |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/sh7372.dtsi b/arch/arm/boot/dts/sh7372.dtsi
index da03ee6..00f1645 100644
--- a/arch/arm/boot/dts/sh7372.dtsi
+++ b/arch/arm/boot/dts/sh7372.dtsi
@@ -943,6 +943,7 @@
 			interrupt-controller;
 			#address-cells = <1>;
 			#size-cells = <1>;
+			#interrupt-cells = <1>;
 			ranges;
 
 			reg = <0xe6900000 0x70>;
@@ -1052,6 +1053,7 @@
 			interrupt-controller;
 			#address-cells = <1>;
 			#size-cells = <1>;
+			#interrupt-cells = <1>;
 			ranges;
 
 			reg = <0xe6900008 0x70>;
-- 
1.7.2.5
