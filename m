From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Tue, 24 Apr 2012 17:13:17 +0200
Subject: [PATCH 1/2] arm: imx: mx35_3ds: make mx35pdk_timer static
In-Reply-To: <1335280398-19769-1-git-send-email-mkl@pengutronix.de>
References: <1335280398-19769-1-git-send-email-mkl@pengutronix.de>
Message-ID: <1335280398-19769-2-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 arch/arm/mach-imx/mach-mx35_3ds.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx35_3ds.c b/arch/arm/mach-imx/mach-mx35_3ds.c
index 6ae51c6..c433187 100644
--- a/arch/arm/mach-imx/mach-mx35_3ds.c
+++ b/arch/arm/mach-imx/mach-mx35_3ds.c
@@ -419,7 +419,7 @@ static void __init mx35pdk_timer_init(void)
 	mx35_clocks_init();
 }
 
-struct sys_timer mx35pdk_timer = {
+static struct sys_timer mx35pdk_timer = {
 	.init	= mx35pdk_timer_init,
 };
 
-- 
1.7.4.1
