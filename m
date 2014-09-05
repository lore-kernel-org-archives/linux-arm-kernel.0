From: rric@kernel.org (Robert Richter)
Date: Fri,  5 Sep 2014 09:46:44 +0200
Subject: [PATCH v2 3/4] arm64,
 thunder: Document devicetree bindings for Cavium Thunder SoC
In-Reply-To: <1409903205-2762-1-git-send-email-rric@kernel.org>
References: <1409903205-2762-1-git-send-email-rric@kernel.org>
Message-ID: <1409903205-2762-4-git-send-email-rric@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>

This patch adds documentation for the devicetree bindings used by the
DT files of Cavium Thunder SoC platforms.

Signed-off-by: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 Documentation/devicetree/bindings/arm/cavium-thunder.txt | 10 ++++++++++
 Documentation/devicetree/bindings/arm/cpus.txt           |  1 +
 2 files changed, 11 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/cavium-thunder.txt

diff --git a/Documentation/devicetree/bindings/arm/cavium-thunder.txt b/Documentation/devicetree/bindings/arm/cavium-thunder.txt
new file mode 100644
index 000000000000..6f63a5866902
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/cavium-thunder.txt
@@ -0,0 +1,10 @@
+Cavium Thunder platform device tree bindings
+--------------------------------------------
+
+Boards with Cavium's Thunder SoC shall have following properties.
+
+Root Node
+---------
+Required root node properties:
+
+  - compatible = "cavium,thunder-88xx";
diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index 298e2f6b33c6..578796a2cfa9 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -166,6 +166,7 @@ nodes to be present and contain the properties described below.
 			    "arm,cortex-r5"
 			    "arm,cortex-r7"
 			    "brcm,brahma-b15"
+			    "cavium,thunder"
 			    "faraday,fa526"
 			    "intel,sa110"
 			    "intel,sa1100"
-- 
2.0.1
