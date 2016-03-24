From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 24 Mar 2016 17:50:13 +0100
Subject: [PATCH v3 16/18] dt-bindings: Add OXNAS bindings
In-Reply-To: <1458838215-23314-1-git-send-email-narmstrong@baylibre.com>
References: <1458838215-23314-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1458838215-23314-17-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/arm/oxnas.txt | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/oxnas.txt

diff --git a/Documentation/devicetree/bindings/arm/oxnas.txt b/Documentation/devicetree/bindings/arm/oxnas.txt
new file mode 100644
index 0000000..f3567c5
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/oxnas.txt
@@ -0,0 +1,9 @@
+PLX Technology OXNAS SoCs Family device tree bindings
+-------------------------------------------
+
+Boards with the OX810SE SoC shall have the following properties:
+  Required root node property:
+    compatible: "oxsemi,ox810se"
+
+Board compatible values:
+  - "wd,mbwe" (OX810SE)
-- 
1.9.1
