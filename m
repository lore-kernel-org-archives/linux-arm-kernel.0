From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 16 Sep 2015 17:37:01 +0200
Subject: [PATCH v2 5/7] ARM: at91/defconfig: sama5: add PIO4 controller support
In-Reply-To: <1442417823-15850-1-git-send-email-ludovic.desroches@atmel.com>
References: <1442417823-15850-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1442417823-15850-6-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SAMA5D2 chip family has a new PIO controller.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 arch/arm/mach-at91/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 89a755b..9e4067c 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -5,6 +5,7 @@ menuconfig ARCH_AT91
 	select COMMON_CLK_AT91
 	select PINCTRL
 	select PINCTRL_AT91
+	select PINCTRL_AT91PIO4
 	select SOC_BUS
 
 if ARCH_AT91
-- 
2.5.0
