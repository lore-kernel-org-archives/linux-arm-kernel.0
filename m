From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed, 22 Feb 2017 03:29:26 +0100
Subject: [PATCH v2 6/8] Documentation: devicetree: arm: marvell: Document
 IAP140
In-Reply-To: <20170222022929.10540-1-afaerber@suse.de>
References: <20170222022929.10540-1-afaerber@suse.de>
Message-ID: <20170222022929.10540-7-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v1 -> v2:
 * Adopted "marvell" vendor prefix (Thomas)
 * Documented Andromeda Box Edge as example
 
 Documentation/devicetree/bindings/arm/marvell/iap140.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/iap140.txt

diff --git a/Documentation/devicetree/bindings/arm/marvell/iap140.txt b/Documentation/devicetree/bindings/arm/marvell/iap140.txt
new file mode 100644
index 0000000..37c6d92
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/marvell/iap140.txt
@@ -0,0 +1,11 @@
+Marvell IAP140 Device Tree Bindings
+-----------------------------------
+
+Boards using a SoC of the Marvell IAP140 family must carry the following
+root node property:
+
+ - compatible :  must contain "marvell,iap140"
+
+Example:
+
+    compatible = "marvell,andromeda-box-edge", "marvell,iap140";
-- 
2.10.2
