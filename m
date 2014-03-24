From: mohun106@gmail.com (mohun106 at gmail.com)
Date: Mon, 24 Mar 2014 14:39:39 +0530
Subject: [PATCH v2 3/3] Documentation: add devicetree bindings for Cavium
 Thunder SoC
In-Reply-To: <1395652179-9216-1-git-send-email-mohun106@gmail.com>
References: <1395652179-9216-1-git-send-email-mohun106@gmail.com>
Message-ID: <1395652179-9216-4-git-send-email-mohun106@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>

This patch adds documentation for the devicetree bindings used by the
DT files of Cavium Thunder SoC platforms.

Signed-off-by: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
---
 .../devicetree/bindings/arm/cavium-thunder.txt     |    9 +++++++++
 Documentation/devicetree/bindings/arm/cpus.txt     |    1 +
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/cavium-thunder.txt b/Documentation/devicetree/bindings/arm/cavium-thunder.txt
new file mode 100644
index 0000000..6ea0a34
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/cavium-thunder.txt
@@ -0,0 +1,9 @@
+Cavium Thunder platform device tree bindings
+---------------------------------------------
+
+Boards with Cavium's Thunder SoC shall have following properties.
+
+Root Node
+---------
+Required root node properties:
+    - compatible = "cavium,thunder";
diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index 333f4ae..f6cadf1 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -163,6 +163,7 @@ nodes to be present and contain the properties described below.
 			    "arm,cortex-r4"
 			    "arm,cortex-r5"
 			    "arm,cortex-r7"
+			    "cavium,thunder"
 			    "faraday,fa526"
 			    "intel,sa110"
 			    "intel,sa1100"
-- 
1.7.1
