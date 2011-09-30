From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 30 Sep 2011 17:56:41 +0100
Subject: [RFC PATCH 2/3] ARM: sound/arm/aaci.c: Define amba module alias
In-Reply-To: <1317401802-24362-1-git-send-email-dave.martin@linaro.org>
References: <1317401802-24362-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1317401802-24362-3-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 sound/arm/aaci.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/arm/aaci.c b/sound/arm/aaci.c
index d0cead3..2e68bfd 100644
--- a/sound/arm/aaci.c
+++ b/sound/arm/aaci.c
@@ -1097,6 +1097,8 @@ static struct amba_id aaci_ids[] = {
 	{ 0, 0 },
 };
 
+MODULE_ALIAS("amba:???41041");
+
 static struct amba_driver aaci_driver = {
 	.drv		= {
 		.name	= DRIVER_NAME,
-- 
1.7.4.1
