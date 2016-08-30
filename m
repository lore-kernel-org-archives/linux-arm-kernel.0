From: andrew@aj.id.au (Andrew Jeffery)
Date: Tue, 30 Aug 2016 17:25:55 +0930
Subject: [PATCH v3 2/7] mach-aspeed: Select GPIO driver
In-Reply-To: <20160830075600.11559-1-andrew@aj.id.au>
References: <20160830075600.11559-1-andrew@aj.id.au>
Message-ID: <20160830075600.11559-3-andrew@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/mach-aspeed/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-aspeed/Kconfig b/arch/arm/mach-aspeed/Kconfig
index f3f8c5c658db..5aba9598f821 100644
--- a/arch/arm/mach-aspeed/Kconfig
+++ b/arch/arm/mach-aspeed/Kconfig
@@ -7,6 +7,8 @@ menuconfig ARCH_ASPEED
 	select MOXART_TIMER
 	select MFD_SYSCON
 	select PINCTRL
+	select GPIOLIB
+	select GPIO_ASPEED
 	help
 	  Say Y here if you want to run your kernel on an ASpeed BMC SoC.
 
-- 
2.9.3.1.g0db844e
