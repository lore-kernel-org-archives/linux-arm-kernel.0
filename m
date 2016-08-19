From: andrew@aj.id.au (Andrew Jeffery)
Date: Fri, 19 Aug 2016 22:17:00 +0930
Subject: [PATCH v2 2/7] mach-aspeed: Select GPIO driver
In-Reply-To: <20160819124705.24633-1-andrew@aj.id.au>
References: <20160819124705.24633-1-andrew@aj.id.au>
Message-ID: <20160819124705.24633-3-andrew@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/mach-aspeed/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-aspeed/Kconfig b/arch/arm/mach-aspeed/Kconfig
index 25a0ae01429e..8d2f8ed890ce 100644
--- a/arch/arm/mach-aspeed/Kconfig
+++ b/arch/arm/mach-aspeed/Kconfig
@@ -6,6 +6,8 @@ menuconfig ARCH_ASPEED
 	select ASPEED_WATCHDOG
 	select MOXART_TIMER
 	select PINCTRL
+	select GPIOLIB
+	select GPIO_ASPEED
 	help
 	  Say Y here if you want to run your kernel on an ASpeed BMC SoC.
 
-- 
2.9.3
