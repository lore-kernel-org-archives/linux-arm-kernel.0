From: gabriel.fernandez@linaro.org (Gabriel Fernandez)
Date: Tue, 23 Jun 2015 16:09:21 +0200
Subject: [PATCH 3/9] drivers: clk: st: Remove unused code
In-Reply-To: <1435068567-30995-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1435068567-30995-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1435068567-30995-4-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove this duplicated code due to a bad copy / paste.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
---
 drivers/clk/st/clkgen-fsyn.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/clk/st/clkgen-fsyn.c b/drivers/clk/st/clkgen-fsyn.c
index e6d7073..e7e6782 100644
--- a/drivers/clk/st/clkgen-fsyn.c
+++ b/drivers/clk/st/clkgen-fsyn.c
@@ -1082,10 +1082,6 @@ static const struct of_device_id quadfs_of_match[] = {
 		.compatible = "st,stih407-quadfs660-D",
 		.data = &st_fs660c32_D_407
 	},
-	{
-		.compatible = "st,stih407-quadfs660-D",
-		.data = (void *)&st_fs660c32_D_407
-	},
 	{}
 };
 
-- 
1.9.1
