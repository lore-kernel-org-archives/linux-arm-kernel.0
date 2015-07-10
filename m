From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 10 Jul 2015 15:45:44 -0700
Subject: [PATCH 4/7] ARM: mvebu: Remove clk-provider.h include
In-Reply-To: <1436568347-24554-1-git-send-email-sboyd@codeaurora.org>
References: <1436568347-24554-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1436568347-24554-5-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This file doesn't use the clk provider APIs. Remove the include.

Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

Please ack if you want this to go through clk-tree.

 arch/arm/mach-mvebu/board-v7.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
index afee9083ad92..9f739f3cad4c 100644
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -14,7 +14,6 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/clk-provider.h>
 #include <linux/of_address.h>
 #include <linux/of_fdt.h>
 #include <linux/of_platform.h>
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
