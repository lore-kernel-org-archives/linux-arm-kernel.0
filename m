From: t-kristo@ti.com (Tero Kristo)
Date: Mon, 31 Mar 2014 18:16:32 +0300
Subject: [PATCH 53/55] ARM: OMAP4: CM: remove unnecessary cm*_44xx.h header
 files from core code
In-Reply-To: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
References: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Message-ID: <1396278994-12624-54-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These are not needed for anything.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cm44xx.c     |    2 --
 arch/arm/mach-omap2/cminst44xx.c |    2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/arm/mach-omap2/cm44xx.c b/arch/arm/mach-omap2/cm44xx.c
index 506974b..14d8256 100644
--- a/arch/arm/mach-omap2/cm44xx.c
+++ b/arch/arm/mach-omap2/cm44xx.c
@@ -19,8 +19,6 @@
 #include <linux/io.h>
 
 #include <linux/power/omap/cm.h>
-#include "cm1_44xx.h"
-#include "cm2_44xx.h"
 
 /* CM1 hardware module low-level functions */
 
diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index 13c4e0b..3d0b8ae 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -24,8 +24,6 @@
 #include <linux/power/omap/prm.h>
 #include <linux/power/omap/clockdomain.h>
 #include <linux/power/omap/cm.h>
-#include "cm1_44xx.h"
-#include "cm2_44xx.h"
 #include <linux/power/omap/cm44xx.h>
 #include <linux/power/omap/prcm44xx.h>
 #include <linux/power/omap/prm44xx.h>
-- 
1.7.9.5
