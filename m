From: colin.king@canonical.com (Colin King)
Date: Mon, 25 Apr 2016 22:42:25 +0100
Subject: [PATCH] mfd: ab8500-debugfs: trivial fix of spelling mistake on
 "between"
Message-ID: <1461620545-29731-1-git-send-email-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

fix spelling mistake, beetween -> between

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/mfd/ab8500-debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/ab8500-debugfs.c b/drivers/mfd/ab8500-debugfs.c
index 69d9fff..0aecd7b 100644
--- a/drivers/mfd/ab8500-debugfs.c
+++ b/drivers/mfd/ab8500-debugfs.c
@@ -2563,7 +2563,7 @@ static ssize_t ab8500_gpadc_trig_timer_write(struct file *file,
 
 	if (user_trig_timer & ~0xFF) {
 		dev_err(dev,
-			"debugfs error input: should be beetween 0 to 255\n");
+			"debugfs error input: should be between 0 to 255\n");
 		return -EINVAL;
 	}
 
-- 
2.7.4
