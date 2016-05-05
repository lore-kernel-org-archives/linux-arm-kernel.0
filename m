From: yangbo.lu@nxp.com (Yangbo Lu)
Date: Thu, 5 May 2016 11:12:24 +0800
Subject: [v10, 1/7] Documentation: DT: update Freescale DCFG compatible
In-Reply-To: <1462417950-46796-1-git-send-email-yangbo.lu@nxp.com>
References: <1462417950-46796-1-git-send-email-yangbo.lu@nxp.com>
Message-ID: <1462417950-46796-2-git-send-email-yangbo.lu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update Freescale DCFG compatible with 'fsl,<chip>-dcfg' instead
of 'fsl,ls1021a-dcfg' to include more chips such as ls1021a,
ls1043a, and ls2080a.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
Changes for v8:
	- Added this patch
Changes for v9:
	- Added a list for the possible compatibles
Changes for v10:
	- None
---
 Documentation/devicetree/bindings/arm/fsl.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index 752a685..465cba1 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -119,7 +119,11 @@ Freescale DCFG
 configuration and status for the device. Such as setting the secondary
 core start address and release the secondary core from holdoff and startup.
   Required properties:
-  - compatible: should be "fsl,ls1021a-dcfg"
+  - compatible: should be "fsl,<chip>-dcfg"
+    Possible compatibles:
+	"fsl,ls1021a-dcfg"
+	"fsl,ls1043a-dcfg"
+	"fsl,ls2080a-dcfg"
   - reg : should contain base address and length of DCFG memory-mapped registers
 
 Example:
-- 
2.1.0.27.g96db324
