From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 12 Jul 2012 11:57:50 +0200
Subject: [PATCH 4/7] rtc/mc13xxx: add support for the rtc in the mc34708 pmic
In-Reply-To: <1342087073-3892-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1342087073-3892-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1342087073-3892-5-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: rtc-linux at googlegroups.com
---
 drivers/rtc/rtc-mc13xxx.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rtc/rtc-mc13xxx.c b/drivers/rtc/rtc-mc13xxx.c
index 0ce0602..2643d88 100644
--- a/drivers/rtc/rtc-mc13xxx.c
+++ b/drivers/rtc/rtc-mc13xxx.c
@@ -404,6 +404,8 @@ static const struct platform_device_id mc13xxx_rtc_idtable[] = {
 		.name = "mc13783-rtc",
 	}, {
 		.name = "mc13892-rtc",
+	}, {
+		.name = "mc34708-rtc",
 	},
 	{ /* sentinel */ }
 };
-- 
1.7.10.4
