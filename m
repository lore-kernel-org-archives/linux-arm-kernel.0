From: zhang.lyra@gmail.com (zhang.lyra at gmail.com)
Date: Mon, 29 Sep 2014 19:48:34 +0800
Subject: [PATCH 6/6] Documentation: Add entry for Spreadtrum's Shark64 SoC
In-Reply-To: <1411991314-6636-1-git-send-email-zhang.lyra@gmail.com>
References: <1411991314-6636-1-git-send-email-zhang.lyra@gmail.com>
Message-ID: <1411991314-6636-7-git-send-email-zhang.lyra@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "chunyan.zhang" <chunyan.zhang@spreadtrum.com>

Adds a devicetree binding documentation for Spreadtrum's Shark64 SoC.

Signed-off-by: chunyan.zhang <chunyan.zhang@spreadtrum.com>
---
 Documentation/devicetree/bindings/arm/sprd.txt |    6 ++++++
 1 file changed, 6 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/sprd.txt

diff --git a/Documentation/devicetree/bindings/arm/sprd.txt b/Documentation/devicetree/bindings/arm/sprd.txt
new file mode 100644
index 0000000..b6dc143
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/sprd.txt
@@ -0,0 +1,6 @@
+Spreadtrum Platforms Device Tree Bindings
+----------------------------------------------------
+
+Shark64 Board
+Required root node properties:
+        - compatible = "sprd,shark64";
-- 
1.7.9.5
