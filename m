From: Alison_Chaiken@mentor.com (Chaiken, Alison)
Date: Thu, 15 Nov 2012 23:32:51 +0000
Subject: [PATCH] Documentation: correct argument list for
 of_platform_populate correction to match of_platform.h prototype
Message-ID: <60BA5429A0E1584BA3633194F6F993B501482A65@NA-MBX-02.mgc.mentorg.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From fd4450ac6bdcf62a84b0d029b36506e7fd567688 Mon Sep 17 00:00:00 2001
From: Alison Chaiken <alchaiken@gmail.com>
Date: Thu, 1 Nov 2012 01:12:38 -0700
Subject: [PATCH] Argument list for of_platform_populate correction to match of_platform.h prototype
 
Signed-off-by: Alison Chaiken <alison_chaiken@mentor.com>
---
 Documentation/devicetree/usage-model.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)
 
diff --git a/Documentation/devicetree/usage-model.txt b/Documentation/devicetree/usage-model.txt
index c5a8009..daa56a2 100644
--- a/Documentation/devicetree/usage-model.txt
+++ b/Documentation/devicetree/usage-model.txt
@@ -347,7 +347,7 @@ later), which will happily live at the base of the Linux /sys/devices
  tree.  Therefore, if a DT node is at the root of the tree, then it
  really probably is best registered as a platform_device.
  
-Linux board support code calls of_platform_populate(NULL, NULL, NULL)
+Linux board support code calls of_platform_populate(NULL, NULL, NULL, NULL)
  to kick off discovery of devices at the root of the tree.  The
  parameters are all NULL because when starting from the root of the
  tree, there is no need to provide a starting node (the first NULL), a
-- 
 1.7.1
 
