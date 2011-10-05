From: dave.martin@linaro.org (Dave Martin)
Date: Wed,  5 Oct 2011 17:05:07 +0100
Subject: [PATCH 16/16] sound: aaci: Enable module alias autogeneration for
	AMBA drivers
In-Reply-To: <1317830707-17517-1-git-send-email-dave.martin@linaro.org>
References: <1317830707-17517-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1317830707-17517-17-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 sound/arm/aaci.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/arm/aaci.c b/sound/arm/aaci.c
index e518d38..b37b702a 100644
--- a/sound/arm/aaci.c
+++ b/sound/arm/aaci.c
@@ -1097,6 +1097,8 @@ static struct amba_id aaci_ids[] = {
 	{ 0, 0 },
 };
 
+MODULE_DEVICE_TABLE(amba, aaci_ids);
+
 static struct amba_driver aaci_driver = {
 	.drv		= {
 		.name	= DRIVER_NAME,
-- 
1.7.4.1
