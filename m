From: oliver.huebers@web.de (=?UTF-8?q?Oliver=20H=C3=BCbers?=)
Date: Fri, 13 Jul 2018 15:41:03 +0200
Subject: [PATCH 1/4] staging: mt7621-pci: Include preferred headers
Message-ID: <1531489266-20410-1-git-send-email-oliver.huebers@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes the following checkpatch warnings:
Use #include <linux/pci.h> instead of <asm/pci.h>
Use #include <linux/io.h> instead of <asm/io.h>

Signed-off-by: Oliver H?bers <oliver.huebers@web.de>
Signed-off-by: Vanessa Borgmann <nessa.x@web.de>
---
 drivers/staging/mt7621-pci/pci-mt7621.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/mt7621-pci/pci-mt7621.c b/drivers/staging/mt7621-pci/pci-mt7621.c
index 4f56840..e092b5d 100644
--- a/drivers/staging/mt7621-pci/pci-mt7621.c
+++ b/drivers/staging/mt7621-pci/pci-mt7621.c
@@ -44,8 +44,8 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/version.h>
-#include <asm/pci.h>
-#include <asm/io.h>
+#include <linux/pci.h>
+#include <linux/io.h>
 #include <asm/mips-cm.h>
 #include <linux/init.h>
 #include <linux/module.h>
-- 
2.7.4
