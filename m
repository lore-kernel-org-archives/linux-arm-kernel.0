From: j-keerthy@ti.com (Keerthy)
Date: Thu, 15 Oct 2015 10:40:07 +0530
Subject: [PATCH v2 2/3] ARM: dts: AM43x-epos-evm: Add AM438x compatible string
 for epos
In-Reply-To: <1444885808-6306-1-git-send-email-j-keerthy@ti.com>
References: <1444885808-6306-1-git-send-email-j-keerthy@ti.com>
Message-ID: <1444885808-6306-3-git-send-email-j-keerthy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add AM438x compatible property to identify the SoCs on epos evms.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---

Changes in v2:

  * Rebased to latest 4.3-rc5

 Documentation/devicetree/bindings/arm/omap/omap.txt | 5 ++++-
 arch/arm/boot/dts/am43x-epos-evm.dts                | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
index 9f4e513..dc3b5f2 100644
--- a/Documentation/devicetree/bindings/arm/omap/omap.txt
+++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
@@ -100,6 +100,9 @@ SoCs:
 - AM4372
   compatible = "ti,am4372", "ti,am43"
 
+- AM438x
+  compatible = "ti,am438x", "ti,am43"
+
 Boards:
 
 - OMAP3 BeagleBoard : Low cost community board
@@ -142,7 +145,7 @@ Boards:
   compatible = "ti,omap5-evm", "ti,omap5"
 
 - AM43x EPOS EVM
-  compatible = "ti,am43x-epos-evm", "ti,am4372", "ti,am43"
+  compatible = "ti,am43x-epos-evm", "ti,am438x", "ti,am43"
 
 - AM437x GP EVM
   compatible = "ti,am437x-gp-evm", "ti,am4372", "ti,am43"
diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 86c2dfb..1c9b9a0 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -18,7 +18,7 @@
 
 / {
 	model = "TI AM43x EPOS EVM";
-	compatible = "ti,am43x-epos-evm","ti,am4372","ti,am43";
+	compatible = "ti,am43x-epos-evm", "ti,am438x", "ti,am43";
 
 	aliases {
 		display0 = &lcd0;
-- 
1.9.1
