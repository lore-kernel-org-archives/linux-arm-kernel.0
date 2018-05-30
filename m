From: m.purski@samsung.com (Maciej Purski)
Date: Wed, 30 May 2018 14:15:56 +0200
Subject: [PATCH v2 05/10] panel/hv070wsa-100: add DT bindings
In-Reply-To: <1527682561-1386-1-git-send-email-m.purski@samsung.com>
References: <1527682561-1386-1-git-send-email-m.purski@samsung.com>
 <CGME20180530121626eucas1p288656bbbace0c333decadff418e13c34@eucas1p2.samsung.com>
Message-ID: <1527682561-1386-6-git-send-email-m.purski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrzej Hajda <a.hajda@samsung.com>

The patch adds bindings to BOE HV070-WSA WSVGA panel.
Bindings are compatible with simple panel bindings.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 .../devicetree/bindings/display/panel/boe,hv070wsa-100.txt         | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/boe,hv070wsa-100.txt

diff --git a/Documentation/devicetree/bindings/display/panel/boe,hv070wsa-100.txt b/Documentation/devicetree/bindings/display/panel/boe,hv070wsa-100.txt
new file mode 100644
index 0000000..bfc20ac
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/boe,hv070wsa-100.txt
@@ -0,0 +1,7 @@
+BOE HV070WSA-100 7.01" WSVGA TFT LCD panel
+
+Required properties:
+- compatible: should be "boe,hv070wsa-100"
+
+This binding is compatible with the simple-panel binding, which is specified
+in simple-panel.txt in this directory.
-- 
2.7.4
