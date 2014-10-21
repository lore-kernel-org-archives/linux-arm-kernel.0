From: johan@kernel.org (Johan Hovold)
Date: Tue, 21 Oct 2014 19:37:54 +0200
Subject: [PATCH v2 08/20] rtc: omap: make platform-device id table const
In-Reply-To: <1413913086-12730-1-git-send-email-johan@kernel.org>
References: <1412881594-25678-1-git-send-email-johan@kernel.org>
 <1413913086-12730-1-git-send-email-johan@kernel.org>
Message-ID: <1413913086-12730-9-git-send-email-johan@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make platform-device id table const.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/rtc/rtc-omap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index dbb88e46c25d..bdee29674589 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -342,7 +342,7 @@ static int omap_rtc_timer;
 #define	OMAP_RTC_DATA_AM3352_IDX	1
 #define	OMAP_RTC_DATA_DA830_IDX		2
 
-static struct platform_device_id omap_rtc_devtype[] = {
+static const struct platform_device_id omap_rtc_devtype[] = {
 	{
 		.name	= DRIVER_NAME,
 	},
-- 
2.0.4
