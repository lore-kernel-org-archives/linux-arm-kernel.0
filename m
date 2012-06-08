From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri,  8 Jun 2012 12:04:50 +0200
Subject: [PATCH] ARM: imx27/dt: make dt_compat entry const
Message-ID: <1339149890-18973-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/imx27-dt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/imx27-dt.c b/arch/arm/mach-imx/imx27-dt.c
index ed38d03..779e539 100644
--- a/arch/arm/mach-imx/imx27-dt.c
+++ b/arch/arm/mach-imx/imx27-dt.c
@@ -74,7 +74,7 @@ static struct sys_timer imx27_timer = {
 	.init = imx27_timer_init,
 };
 
-static const char *imx27_dt_board_compat[] __initdata = {
+static const char * const imx27_dt_board_compat[] __initconst = {
 	"fsl,imx27",
 	NULL
 };
-- 
1.7.10
