From: grinberg@compulab.co.il (Igor Grinberg)
Date: Tue,  9 Mar 2010 11:43:49 +0200
Subject: [PATCH 2/5] [ARM] pxa/cm-x300: da903x WLED is not connected on cm-x300
In-Reply-To: <1268127832-20563-1-git-send-email-grinberg@compulab.co.il>
References: <1268127832-20563-1-git-send-email-grinberg@compulab.co.il>
Message-ID: <1268127832-20563-2-git-send-email-grinberg@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/mach-pxa/cm-x300.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
index 0e538d8..13fdfd8 100644
--- a/arch/arm/mach-pxa/cm-x300.c
+++ b/arch/arm/mach-pxa/cm-x300.c
@@ -637,10 +637,6 @@ struct da9030_battery_info cm_x300_battery_info = {
 /* DA9030 */
 struct da903x_subdev_info cm_x300_da9030_subdevs[] = {
 	{
-		.name = "da903x-backlight",
-		.id = DA9030_ID_WLED,
-	},
-	{
 		.name = "da903x-battery",
 		.id = DA9030_ID_BAT,
 		.platform_data = &cm_x300_battery_info,
-- 
1.6.4.4
