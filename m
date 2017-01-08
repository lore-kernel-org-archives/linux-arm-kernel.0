From: scott@matheina.com (Scott Matheina)
Date: Sun,  8 Jan 2017 17:00:39 -0600
Subject: [PATCH 2/2] staging/media/s5p-cec/exynos_hdmi_cecctrl.c Fixed blank
 line before closing brace '}'
In-Reply-To: <1483916446-6418-1-git-send-email-scott@matheina.com>
References: <1483916446-6418-1-git-send-email-scott@matheina.com>
Message-ID: <1483916446-6418-2-git-send-email-scott@matheina.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixed checkpatch check blank line before closing brace '}'

Signed-off-by: Scott Matheina <scott@matheina.com>
---
 drivers/staging/media/s5p-cec/exynos_hdmi_cecctrl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/media/s5p-cec/exynos_hdmi_cecctrl.c b/drivers/staging/media/s5p-cec/exynos_hdmi_cecctrl.c
index f2b24a4..1edf667 100644
--- a/drivers/staging/media/s5p-cec/exynos_hdmi_cecctrl.c
+++ b/drivers/staging/media/s5p-cec/exynos_hdmi_cecctrl.c
@@ -87,7 +87,6 @@ void s5p_cec_mask_tx_interrupts(struct s5p_cec_dev *cec)
 	reg |= S5P_CEC_IRQ_TX_DONE;
 	reg |= S5P_CEC_IRQ_TX_ERROR;
 	writeb(reg, cec->reg + S5P_CEC_IRQ_MASK);
-
 }
 
 void s5p_cec_unmask_tx_interrupts(struct s5p_cec_dev *cec)
-- 
2.7.4
