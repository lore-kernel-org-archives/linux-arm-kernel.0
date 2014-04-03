From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu,  3 Apr 2014 10:33:49 +0200
Subject: [PATCH] of: add vendor prefix for I2SE GmbH
Message-ID: <1396514029-5769-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add i2se to the list of DT vendor prefixes.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt |    1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index e9d19e2..f27f6c9 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -45,6 +45,7 @@ haoyu	Haoyu Microelectronic Co. Ltd.
 hisilicon	Hisilicon Limited.
 honeywell	Honeywell
 hp	Hewlett Packard
+i2se	I2SE GmbH
 ibm	International Business Machines (IBM)
 idt	Integrated Device Technologies, Inc.
 img	Imagination Technologies Ltd.
-- 
1.7.10.4
