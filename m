From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 15 Jan 2013 12:55:52 +0000
Subject: [PATCH 12/26] mfd: ab8500-debugfs: Use NULL to initialise remaining
 NULL pointer
In-Reply-To: <1358254566-12419-1-git-send-email-lee.jones@linaro.org>
References: <1358254566-12419-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1358254566-12419-13-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Partly for coding style reasons, but mostly because sparse warns on it.

This patch is a completion of a previous patch my Mark Brown.

Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/ab8500-debugfs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/ab8500-debugfs.c b/drivers/mfd/ab8500-debugfs.c
index 03eacf1..4f36907 100644
--- a/drivers/mfd/ab8500-debugfs.c
+++ b/drivers/mfd/ab8500-debugfs.c
@@ -60,7 +60,7 @@ struct ab8500_prcmu_ranges {
 static struct ab8500_prcmu_ranges debug_ranges[AB8500_NUM_BANKS] = {
 	[0x0] = {
 		.num_ranges = 0,
-		.range = 0,
+		.range = NULL,
 	},
 	[AB8500_SYS_CTRL1_BLOCK] = {
 		.num_ranges = 3,
-- 
1.7.9.5
