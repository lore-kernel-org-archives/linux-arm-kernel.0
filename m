From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun, 19 Feb 2017 04:19:58 +0100
Subject: [PATCH 2/4] Documentation: devicetree: arm: Document Marvell IAP140
In-Reply-To: <20170219032000.4674-1-afaerber@suse.de>
References: <20170219032000.4674-1-afaerber@suse.de>
Message-ID: <20170219032000.4674-3-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 Documentation/devicetree/bindings/arm/marvell/iap140.txt | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/iap140.txt

diff --git a/Documentation/devicetree/bindings/arm/marvell/iap140.txt b/Documentation/devicetree/bindings/arm/marvell/iap140.txt
new file mode 100644
index 0000000..25d307c
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/marvell/iap140.txt
@@ -0,0 +1,7 @@
+Marvell IAP140 Device Tree Bindings
+-----------------------------------
+
+Boards using a SoC of the Marvell IAP140 family must carry the following
+root node property:
+
+ - compatible :  must contain "mrvl,iap140"
-- 
2.10.2
