From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 10 Jul 2015 15:50:57 -0700
Subject: [PATCH] arm64: Remove clk-provider.h include
Message-ID: <1436568657-26243-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This file doesn't use the clk provider APIs. Remove the include.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

Please ack if you want this to go through the clk-tree (along
with quite a few other patches that do the same thing). Otherwise,
it's fine if it's applied to the arm64 tree.

 arch/arm64/kernel/setup.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index f3067d4d4e35..926ae8d9abc5 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -34,7 +34,6 @@
 #include <linux/kexec.h>
 #include <linux/crash_dump.h>
 #include <linux/root_dev.h>
-#include <linux/clk-provider.h>
 #include <linux/cpu.h>
 #include <linux/interrupt.h>
 #include <linux/smp.h>
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
