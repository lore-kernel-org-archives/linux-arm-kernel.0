From: yibin.gong@nxp.com (Robin Gong)
Date: Tue, 20 Jun 2017 15:24:50 +0800
Subject: [PATCH v1] firmware: add sdma firmware for i.mx6/i.mx7d
Message-ID: <1497943490-13401-1-git-send-email-yibin.gong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add sdma firmware for i.mx6 and i.mx7d family, this patch depends
on the below:

 commit 3123d78e09d2 ("imx: Add SDMA firmware for Freescale i.MX6/7 SoCs")

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 firmware/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/firmware/Makefile b/firmware/Makefile
index fa3e81c..edc86a0 100644
--- a/firmware/Makefile
+++ b/firmware/Makefile
@@ -65,6 +65,7 @@ fw-shipped-$(CONFIG_DVB_AV7110) += av7110/bootcode.bin
 fw-shipped-$(CONFIG_DVB_TTUSB_BUDGET) += ttusb-budget/dspbootcode.bin
 fw-shipped-$(CONFIG_E100) += e100/d101m_ucode.bin e100/d101s_ucode.bin \
 			     e100/d102e_ucode.bin
+fw-shipped-$(CONFIG_IMX_SDMA) += imx/sdma/sdma-imx6q.bin imx/sdma/sdma-imx7d.bin
 fw-shipped-$(CONFIG_MYRI_SBUS) += myricom/lanai.bin
 fw-shipped-$(CONFIG_PCMCIA_PCNET) += cis/LA-PCM.cis cis/PCMLM28.cis \
 				     cis/DP83903.cis cis/NE2K.cis \
-- 
1.9.1
