From: dave.martin@linaro.org (Dave Martin)
Date: Wed,  5 Oct 2011 17:05:00 +0100
Subject: [PATCH 09/16] rtc: pl030: Enable module alias autogeneration for AMBA
	drivers
In-Reply-To: <1317830707-17517-1-git-send-email-dave.martin@linaro.org>
References: <1317830707-17517-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1317830707-17517-10-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 drivers/rtc/rtc-pl030.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/rtc/rtc-pl030.c b/drivers/rtc/rtc-pl030.c
index 1d28d44..02111fe 100644
--- a/drivers/rtc/rtc-pl030.c
+++ b/drivers/rtc/rtc-pl030.c
@@ -174,6 +174,8 @@ static struct amba_id pl030_ids[] = {
 	{ 0, 0 },
 };
 
+MODULE_DEVICE_TABLE(amba, pl030_ids);
+
 static struct amba_driver pl030_driver = {
 	.drv		= {
 		.name	= "rtc-pl030",
-- 
1.7.4.1
