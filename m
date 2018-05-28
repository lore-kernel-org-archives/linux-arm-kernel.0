From: m.purski@samsung.com (Maciej Purski)
Date: Mon, 28 May 2018 11:47:09 +0200
Subject: [PATCH 05/12] panel/hv070wsa-100: add DT bindings
In-Reply-To: <1527500833-16005-1-git-send-email-m.purski@samsung.com>
References: <1527500833-16005-1-git-send-email-m.purski@samsung.com>
 <CGME20180528094726eucas1p14c9d821881865955a4d8b1735a650c8f@eucas1p1.samsung.com>
Message-ID: <1527500833-16005-6-git-send-email-m.purski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
