From: scott@matheina.com (Scott Matheina)
Date: Sun,  8 Jan 2017 17:00:38 -0600
Subject: [PATCH 1/2] staging:media:s5p-cec:exynos_hdmi_cecctrl.c Fixed
 Alignment should match open parenthesis
Message-ID: <1483916446-6418-1-git-send-email-scott@matheina.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixed Checkpatch check "Alignment should match open parenthesis"

Signed-off-by: Scott Matheina <scott@matheina.com>
---
 drivers/staging/media/s5p-cec/exynos_hdmi_cecctrl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/s5p-cec/exynos_hdmi_cecctrl.c b/drivers/staging/media/s5p-cec/exynos_hdmi_cecctrl.c
index ce95e0f..f2b24a4 100644
--- a/drivers/staging/media/s5p-cec/exynos_hdmi_cecctrl.c
+++ b/drivers/staging/media/s5p-cec/exynos_hdmi_cecctrl.c
@@ -186,13 +186,13 @@ u32 s5p_cec_get_status(struct s5p_cec_dev *cec)
 void s5p_clr_pending_tx(struct s5p_cec_dev *cec)
 {
 	writeb(S5P_CEC_IRQ_TX_DONE | S5P_CEC_IRQ_TX_ERROR,
-					cec->reg + S5P_CEC_IRQ_CLEAR);
+	       cec->reg + S5P_CEC_IRQ_CLEAR);
 }
 
 void s5p_clr_pending_rx(struct s5p_cec_dev *cec)
 {
 	writeb(S5P_CEC_IRQ_RX_DONE | S5P_CEC_IRQ_RX_ERROR,
-					cec->reg + S5P_CEC_IRQ_CLEAR);
+	       cec->reg + S5P_CEC_IRQ_CLEAR);
 }
 
 void s5p_cec_get_rx_buf(struct s5p_cec_dev *cec, u32 size, u8 *buffer)
-- 
2.7.4
