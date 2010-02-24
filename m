From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 24 Feb 2010 11:08:15 +0100
Subject: [PATCH 20/39] arm/imx: don't explicitly select GENERIC_GPIO
In-Reply-To: <20100224100649.GA6456@pengutronix.de>
References: <20100224100649.GA6456@pengutronix.de>
Message-ID: <1267006114-31743-20-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARCH_REQUIRE_GPIOLIB selects GPIOLIB which in turn selects GENERIC_GPIO

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/Kconfig |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 39baa60..9c78cfb 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -309,7 +309,6 @@ config ARCH_MXC
 	select GENERIC_TIME
 	select GENERIC_CLOCKEVENTS
 	select ARCH_MTD_XIP
-	select GENERIC_GPIO
 	select ARCH_REQUIRE_GPIOLIB
 	select HAVE_CLK
 	select COMMON_CLKDEV
-- 
1.6.6.2
