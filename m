From: dave.martin@linaro.org (Dave Martin)
Date: Wed,  5 Oct 2011 17:05:01 +0100
Subject: [PATCH 10/16] rtc: pl031: Enable module alias autogeneration for AMBA
	drivers
In-Reply-To: <1317830707-17517-1-git-send-email-dave.martin@linaro.org>
References: <1317830707-17517-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1317830707-17517-11-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 drivers/rtc/rtc-pl031.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/rtc/rtc-pl031.c b/drivers/rtc/rtc-pl031.c
index ff1b84bd..a952c8d 100644
--- a/drivers/rtc/rtc-pl031.c
+++ b/drivers/rtc/rtc-pl031.c
@@ -420,6 +420,8 @@ static struct amba_id pl031_ids[] = {
 	{0, 0},
 };
 
+MODULE_DEVICE_TABLE(amba, pl031_ids);
+
 static struct amba_driver pl031_driver = {
 	.drv = {
 		.name = "rtc-pl031",
-- 
1.7.4.1
