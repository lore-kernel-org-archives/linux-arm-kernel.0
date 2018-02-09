From: chf.fritz@googlemail.com (Christoph Fritz)
Date: Fri,  9 Feb 2018 11:05:20 +0100
Subject: [PATCH 2/3] dt-bindings: regulator: describe da9062's regulator modes
In-Reply-To: <1518170721-28198-1-git-send-email-chf.fritz@googlemail.com>
References: <1518170721-28198-1-git-send-email-chf.fritz@googlemail.com>
Message-ID: <1518170721-28198-3-git-send-email-chf.fritz@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds DT description of da9062's buck regulator modes.

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 Documentation/devicetree/bindings/mfd/da9062.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/da9062.txt b/Documentation/devicetree/bindings/mfd/da9062.txt
index c0a418c..b871bc2 100644
--- a/Documentation/devicetree/bindings/mfd/da9062.txt
+++ b/Documentation/devicetree/bindings/mfd/da9062.txt
@@ -64,6 +64,14 @@ Sub-nodes:
     ldo3     : LDO_3
     ldo4     : LDO_4
 
+  The DA9062 regulators optionally support setting "regulator-initial-mode"
+  and "regulator-mode" for its buck nodes to following numbers listed below:
+
+    0        : BUCK_MODE_MANUAL
+    1        : BUCK_MODE_SLEEP
+    2        : BUCK_MODE_SYNC
+    3        : BUCK_MODE_AUTO
+
   The component follows the standard regulator framework and the bindings
   details of individual regulator device can be found in:
   Documentation/devicetree/bindings/regulator/regulator.txt
-- 
2.1.4
