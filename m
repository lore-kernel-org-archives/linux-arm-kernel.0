From: johan@kernel.org (Johan Hovold)
Date: Thu,  9 Oct 2014 21:06:26 +0200
Subject: [PATCH 04/12] rtc: omap: remove unused register-base define
In-Reply-To: <1412881594-25678-1-git-send-email-johan@kernel.org>
References: <1412881594-25678-1-git-send-email-johan@kernel.org>
Message-ID: <1412881594-25678-5-git-send-email-johan@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove register-base define, which is no longer used.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/rtc/rtc-omap.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 2eca141e784e..d1b5562a148b 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -41,8 +41,6 @@
 
 #define	DRIVER_NAME			"omap_rtc"
 
-#define OMAP_RTC_BASE			0xfffb4800
-
 /* RTC registers */
 #define OMAP_RTC_SECONDS_REG		0x00
 #define OMAP_RTC_MINUTES_REG		0x04
-- 
2.0.4
