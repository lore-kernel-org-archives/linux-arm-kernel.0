From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri,  3 Aug 2012 16:02:57 -0700
Subject: [PATCH/TRIVIAL] ARM: Drop duplicate select for GENERIC_IRQ_PROBE
Message-ID: <1344034977-6105-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Seems that Thomas' and my patches collided during the last merge
window.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e91c7cd..b528d04 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -38,7 +38,6 @@ config ARM
 	select HARDIRQS_SW_RESEND
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
-	select GENERIC_IRQ_PROBE
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select HARDIRQS_SW_RESEND
 	select CPU_PM if (SUSPEND || CPU_IDLE)
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
