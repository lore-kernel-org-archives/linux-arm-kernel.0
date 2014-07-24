From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Fri, 25 Jul 2014 01:00:11 +0200
Subject: [PATCH v2 02/11] Documentation: devicetree: Adapteva boards
In-Reply-To: <1406242820-20140-1-git-send-email-afaerber@suse.de>
References: <1406242820-20140-1-git-send-email-afaerber@suse.de>
Message-ID: <1406242820-20140-3-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We're about to add a device tree for the Parallella board.

Cc: Andreas Olofsson <andreas@adapteva.com>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v2: New
 
 Documentation/devicetree/bindings/arm/adapteva.txt | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/adapteva.txt

diff --git a/Documentation/devicetree/bindings/arm/adapteva.txt b/Documentation/devicetree/bindings/arm/adapteva.txt
new file mode 100644
index 0000000..1d8af9e
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/adapteva.txt
@@ -0,0 +1,7 @@
+Adapteva Platforms Device Tree Bindings
+---------------------------------------
+
+Parallella board
+
+Required root node properties:
+    - compatible = "adapteva,parallella";
-- 
1.9.3
