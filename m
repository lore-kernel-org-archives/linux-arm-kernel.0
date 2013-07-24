From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Wed, 24 Jul 2013 15:09:26 +0200
Subject: [PATCH 1/3] sh-pfc: Remove unneeded mach/<soc>.h includes
In-Reply-To: <1374671368-4681-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1374671368-4681-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1374671368-4681-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SoC-specific mach/<soc>.h headers are included needlesly. Don't
include them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a73a4.c | 1 -
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c | 1 -
 drivers/pinctrl/sh-pfc/pfc-sh7372.c  | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c b/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
index 82bf6ab..2b9c0b3 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
@@ -21,7 +21,6 @@
 #include <linux/kernel.h>
 #include <linux/pinctrl/pinconf-generic.h>
 #include <mach/irqs.h>
-#include <mach/r8a73a4.h>
 
 #include "core.h"
 #include "sh_pfc.h"
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
index f6ea47c..6a7d382 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
@@ -22,7 +22,6 @@
 #include <linux/kernel.h>
 #include <linux/pinctrl/pinconf-generic.h>
 
-#include <mach/r8a7740.h>
 #include <mach/irqs.h>
 
 #include "core.h"
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7372.c b/drivers/pinctrl/sh-pfc/pfc-sh7372.c
index 6dfb187..1528693 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7372.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7372.c
@@ -25,7 +25,6 @@
 #include <linux/pinctrl/pinconf-generic.h>
 
 #include <mach/irqs.h>
-#include <mach/sh7372.h>
 
 #include "core.h"
 #include "sh_pfc.h"
-- 
1.8.1.5
