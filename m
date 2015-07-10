From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 10 Jul 2015 15:45:46 -0700
Subject: [PATCH 6/7] ARM: s3c64xx: Remove clk-provider.h include
In-Reply-To: <1436568347-24554-1-git-send-email-sboyd@codeaurora.org>
References: <1436568347-24554-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1436568347-24554-7-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This file doesn't use the clk provider APIs. Remove the include.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/mach-s3c64xx/common.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-s3c64xx/common.c b/arch/arm/mach-s3c64xx/common.c
index 16547f2641a3..25d6676f8d6e 100644
--- a/arch/arm/mach-s3c64xx/common.c
+++ b/arch/arm/mach-s3c64xx/common.c
@@ -21,7 +21,6 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/clk-provider.h>
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
 #include <linux/serial_core.h>
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
