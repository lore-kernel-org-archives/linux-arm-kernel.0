From: leo.yan@linaro.org (Leo Yan)
Date: Wed, 29 Jul 2015 14:13:40 +0800
Subject: [PATCH] drivers/rtc/rtc-pl031.c: fix typo for author email
Message-ID: <1438150420-15035-1-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The email address missed character ">", so add it.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/rtc/rtc-pl031.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pl031.c b/drivers/rtc/rtc-pl031.c
index 99181fff..41dcb7d 100644
--- a/drivers/rtc/rtc-pl031.c
+++ b/drivers/rtc/rtc-pl031.c
@@ -476,6 +476,6 @@ static struct amba_driver pl031_driver = {
 
 module_amba_driver(pl031_driver);
 
-MODULE_AUTHOR("Deepak Saxena <dsaxena at plexity.net");
+MODULE_AUTHOR("Deepak Saxena <dsaxena@plexity.net>");
 MODULE_DESCRIPTION("ARM AMBA PL031 RTC Driver");
 MODULE_LICENSE("GPL");
-- 
1.9.1
