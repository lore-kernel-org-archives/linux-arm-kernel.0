From: jchandra@broadcom.com (Jayachandran C)
Date: Sat, 20 Feb 2016 19:49:21 +0530
Subject: [PATCH v2 2/5] dt-bindings: Add documentation for Broadcom Vulcan
In-Reply-To: <1455977964-8099-1-git-send-email-jchandra@broadcom.com>
References: <1455977964-8099-1-git-send-email-jchandra@broadcom.com>
Message-ID: <1455977964-8099-3-git-send-email-jchandra@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update arm/cpus.txt to add "brcm,vulcan" CPU. Add documentation
for Broadcom Vulcan boards in arm/bcm/brcm,vulcan-soc.txt

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 Documentation/devicetree/bindings/arm/bcm/brcm,vulcan-soc.txt | 10 ++++++++++
 Documentation/devicetree/bindings/arm/cpus.txt                |  1 +
 2 files changed, 11 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,vulcan-soc.txt

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,vulcan-soc.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,vulcan-soc.txt
new file mode 100644
index 0000000..223ed34
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,vulcan-soc.txt
@@ -0,0 +1,10 @@
+Broadcom Vulcan device tree bindings
+------------------------------------
+
+Boards with Broadcom Vulcan shall have the following root property:
+
+Broadcom Vulcan Evaluation Board:
+  compatible = "brcm,vulcan-eval", "brcm,vulcan-soc";
+
+Generic Vulcan board:
+  compatible = "brcm,vulcan-soc";
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
