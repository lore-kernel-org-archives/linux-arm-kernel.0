From: eric@eukrea.com (=?utf-8?q?Eric=20B=C3=A9nard?=)
Date: Wed, 19 May 2010 18:45:56 +0200
Subject: [PATCH 01/13] eukrea_mbimx27-baseboard: fix typo in display name
Message-ID: <1274287568-30253-1-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c b/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c
index f3b169d..c9e4452 100644
--- a/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c
+++ b/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c
@@ -127,7 +127,7 @@ static struct platform_device leds_gpio = {
 static struct imx_fb_videomode eukrea_mbimx27_modes[] = {
 	{
 		.mode = {
-			.name		= "CMO-QGVA",
+			.name		= "CMO-QVGA",
 			.refresh	= 60,
 			.xres		= 320,
 			.yres		= 240,
-- 
1.6.3.3
