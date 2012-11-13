From: syamsidhardh@gmail.com (Syam Sidhardhan)
Date: Tue, 13 Nov 2012 21:19:49 +0530
Subject: [PATCH 2/3] ARM: prima2: Replace include linux/module.h with
 linux/export.h
Message-ID: <1352821789-6640-1-git-send-email-s.syam@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

include <linux/export.h> is the right to go here.

Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
---
 arch/arm/mach-prima2/pm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-prima2/pm.c b/arch/arm/mach-prima2/pm.c
index fb5a791..f4a2270 100644
--- a/arch/arm/mach-prima2/pm.c
+++ b/arch/arm/mach-prima2/pm.c
@@ -9,7 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/suspend.h>
 #include <linux/slab.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
-- 
1.7.4.1
