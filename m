From: fabf@skynet.be (Fabian Frederick)
Date: Mon, 15 Aug 2016 19:34:44 +0200
Subject: [PATCH 1/1 linux-next RESEND] ARM: multi_v7_defconfig: update
 XILINX_VDMA
Message-ID: <1471282484-10810-1-git-send-email-fabf@skynet.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit fde57a7c4474
("dmaengine: xilinx: Rename driver and config")

renamed config XILINX_VDMA to config XILINX_DMA
Update defconfig accordingly.

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
Sending to arm-soc (suggested by Shawn Guo)

 arch/arm/configs/multi_v7_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 7db8dce..d3ef852 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -784,7 +784,7 @@ CONFIG_MXS_DMA=y
 CONFIG_DMA_BCM2835=y
 CONFIG_DMA_OMAP=y
 CONFIG_QCOM_BAM_DMA=y
-CONFIG_XILINX_VDMA=y
+CONFIG_XILINX_DMA=y
 CONFIG_DMA_SUN6I=y
 CONFIG_STAGING=y
 CONFIG_SENSORS_ISL29018=y
-- 
2.8.1
