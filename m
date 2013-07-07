From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sun, 07 Jul 2013 13:44:29 +0100
Subject: [PATCH RFC 1/9] ARM: debug: fix wording error in DEBUG_LL_UART_NONE
 option help
In-Reply-To: <20130707124326.GP24642@n2100.arm.linux.org.uk>
References: <20130707124326.GP24642@n2100.arm.linux.org.uk>
Message-ID: <E1UvoKL-0006Ha-LV@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DEBUG_LL_UART_NONE option was moved from the top of the list to
the bottom - unfortunately, it still referred to the options "below"
rather than "above".

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig.debug |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 5b7be8d..2cc4b31 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -579,7 +579,7 @@ choice
 		depends on !ARCH_MULTIPLATFORM
 		help
 		  Say Y here if your platform doesn't provide a UART option
-		  below. This relies on your platform choosing the right UART
+		  above. This relies on your platform choosing the right UART
 		  definition internally in order for low-level debugging to
 		  work.
 
-- 
1.7.4.4
