From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Wed, 17 Jul 2013 10:10:13 -0700
Subject: [PATCH 1/3] arm: zynq: slcr: Remove redundant header #includes
In-Reply-To: <1374081015-31431-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1374081015-31431-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1374081015-31431-2-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 arch/arm/mach-zynq/slcr.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/mach-zynq/slcr.c b/arch/arm/mach-zynq/slcr.c
index 50d008d..232c275 100644
--- a/arch/arm/mach-zynq/slcr.c
+++ b/arch/arm/mach-zynq/slcr.c
@@ -14,18 +14,8 @@
  * 02139, USA.
  */
 
-#include <linux/export.h>
 #include <linux/io.h>
-#include <linux/fs.h>
-#include <linux/interrupt.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/of_address.h>
-#include <linux/uaccess.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
-#include <linux/string.h>
 #include <linux/clk/zynq.h>
 #include "common.h"
 
-- 
1.8.3.3
