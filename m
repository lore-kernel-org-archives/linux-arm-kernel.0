From: jchandra@broadcom.com (Jayachandran C)
Date: Sun, 14 Feb 2016 00:16:33 +0530
Subject: [PATCH 2/4] dt-bindings: Add documentation for Broadcom Vulcan
In-Reply-To: <1455389195-31870-1-git-send-email-jchandra@broadcom.com>
References: <1455389195-31870-1-git-send-email-jchandra@broadcom.com>
Message-ID: <1455389195-31870-3-git-send-email-jchandra@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update arm/cpus.txt to add brcm,vulcan CPU. Add documentation
for Broadcom vulcan boards in arm/bcm/brcm,vulcan.txt

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 Documentation/devicetree/bindings/arm/bcm/brcm,vulcan.txt | 9 +++++++++
 Documentation/devicetree/bindings/arm/cpus.txt            | 1 +
 2 files changed, 10 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,vulcan.txt

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,vulcan.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,vulcan.txt
new file mode 100644
index 0000000..dac9eb5
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,vulcan.txt
@@ -0,0 +1,9 @@
+Broadcom Vulcan device tree bindings
+------------------------------------
+
+Boards with Broadcom Vulcan shall have the following properties:
+
+Required root node property:
+
+Vulcan Evaluation Board
+compatible = "brcm,vulcan-eval", "brcm,vulcan";
diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index ae9be07..bc43ad7 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -167,6 +167,7 @@ nodes to be present and contain the properties described below.
 			    "arm,cortex-r5"
 			    "arm,cortex-r7"
 			    "brcm,brahma-b15"
+			    "brcm,vulcan"
 			    "cavium,thunder"
 			    "faraday,fa526"
 			    "intel,sa110"
-- 
1.9.1
