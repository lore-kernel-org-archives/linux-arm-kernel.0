From: venture@google.com (Patrick Venture)
Date: Wed, 28 Jun 2017 12:06:00 -0700
Subject: [PATCH] ARM: aspeed: select GPIOLIB
Message-ID: <20170628190600.171524-1-venture@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Patrick Venture <venture@google.com>
---
 arch/arm/mach-aspeed/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-aspeed/Kconfig b/arch/arm/mach-aspeed/Kconfig
index f3f8c5c658db..b71ab9f37eb1 100644
--- a/arch/arm/mach-aspeed/Kconfig
+++ b/arch/arm/mach-aspeed/Kconfig
@@ -7,6 +7,7 @@ menuconfig ARCH_ASPEED
 	select MOXART_TIMER
 	select MFD_SYSCON
 	select PINCTRL
+	select GPIOLIB
 	help
 	  Say Y here if you want to run your kernel on an ASpeed BMC SoC.
 
-- 
2.13.2.725.g09c95d1e9-goog
