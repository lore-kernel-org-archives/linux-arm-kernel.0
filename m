From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed,  5 Sep 2012 14:03:31 -0700
Subject: [PATCH] ARM: Fix semihosting Kconfig text
Message-ID: <1346879011-7765-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It seems we were missing some text in the title for the
semihosting DEBUG_LL option. Add in the "/O" and fix up some
minor typos in the help text.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/Kconfig.debug | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index f15f82b..e968a52 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -356,15 +356,15 @@ choice
 		  is nothing connected to read from the DCC.
 
 	config DEBUG_SEMIHOSTING
-		bool "Kernel low-level debug output via semihosting I"
+		bool "Kernel low-level debug output via semihosting I/O"
 		help
 		  Semihosting enables code running on an ARM target to use
 		  the I/O facilities on a host debugger/emulator through a
-		  simple SVC calls. The host debugger or emulator must have
+		  simple SVC call. The host debugger or emulator must have
 		  semihosting enabled for the special svc call to be trapped
 		  otherwise the kernel will crash.
 
-		  This is known to work with OpenOCD, as wellas
+		  This is known to work with OpenOCD, as well as
 		  ARM's Fast Models, or any other controlling environment
 		  that implements semihosting.
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
