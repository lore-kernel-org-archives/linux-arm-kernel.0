From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Mon, 11 Jul 2016 18:29:43 -0600
Subject: [PATCH] media: s5p-mfc remove void function return statement
Message-ID: <1468283383-3142-1-git-send-email-shuahkh@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove void function return statement

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 drivers/media/platform/s5p-mfc/s5p_mfc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc.c b/drivers/media/platform/s5p-mfc/s5p_mfc.c
index c96421f..b6fde20 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc.c
@@ -495,7 +495,6 @@ static void s5p_mfc_handle_error(struct s5p_mfc_dev *dev,
 	s5p_mfc_hw_call(dev->mfc_ops, clear_int_flags, dev);
 	s5p_mfc_clock_off();
 	wake_up_dev(dev, reason, err);
-	return;
 }
 
 /* Header parsing interrupt handling */
-- 
2.7.4
