From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon,  5 Jun 2017 14:15:08 -0600
Subject: [PATCH 07/17] coresight: etb10: Fix a typo in a comment line
In-Reply-To: <1496693718-9191-1-git-send-email-mathieu.poirier@linaro.org>
References: <1496693718-9191-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1496693718-9191-8-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>

Delete a character in this description for a condition check.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etb10.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 837aebf22c45..d5b96423e1a5 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -375,7 +375,7 @@ static void etb_update_buffer(struct coresight_device *csdev,
 
 	/*
 	 * Entries should be aligned to the frame size.  If they are not
-	 * go back to the last alignement point to give decoding tools a
+	 * go back to the last alignment point to give decoding tools a
 	 * chance to fix things.
 	 */
 	if (write_ptr % ETB_FRAME_SIZE_WORDS) {
-- 
2.7.4
