From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  7 May 2015 14:38:44 +0100
Subject: [PATCH 12/12] ARM: STi: Update platform level menuconfig 'help'
In-Reply-To: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1431005924-21777-13-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Encompass newer STiH4{07,10} SoC based platforms.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-sti/Kconfig | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-sti/Kconfig b/arch/arm/mach-sti/Kconfig
index cb886de..59928d9 100644
--- a/arch/arm/mach-sti/Kconfig
+++ b/arch/arm/mach-sti/Kconfig
@@ -16,11 +16,9 @@ menuconfig ARCH_STI
 	select PL310_ERRATA_769419 if CACHE_L2X0
 	select RESET_CONTROLLER
 	help
-	  Include support for STiH41x SOCs like STiH415/416 using the device tree
-	  for discovery
-	  More information at Documentation/arm/STiH41x and
-	  at Documentation/devicetree
-
+	  Include support for STMicroelectronics' STiH415/416 and stih407/10
+	  family SoCs using the Device Tree for discovery.  More information
+	  can be found in Documentation/arm/sti/ & Documentation/devicetree.
 
 if ARCH_STI
 
-- 
1.9.1
