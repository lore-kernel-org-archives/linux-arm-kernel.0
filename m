From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 13 Jun 2011 15:37:21 +0800
Subject: [PATCH 2/6] ARM: mxc: sdma on imx25 is a V2 block
In-Reply-To: <1307950645-26529-1-git-send-email-shawn.guo@linaro.org>
References: <1307950645-26529-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1307950645-26529-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sdma on soc imx25 is not a V1 but V2 block.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/plat-mxc/devices/platform-imx-dma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-mxc/devices/platform-imx-dma.c b/arch/arm/plat-mxc/devices/platform-imx-dma.c
index 222e439..1c0ba53 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-dma.c
+++ b/arch/arm/plat-mxc/devices/platform-imx-dma.c
@@ -33,7 +33,7 @@ struct imx_imx_sdma_data {
 
 #ifdef CONFIG_SOC_IMX25
 struct imx_imx_sdma_data imx25_imx_sdma_data __initconst =
-	imx_imx_sdma_data_entry_single(MX25, 1, "imx25", 0);
+	imx_imx_sdma_data_entry_single(MX25, 2, "imx25", 0);
 #endif /* ifdef CONFIG_SOC_IMX25 */
 
 #ifdef CONFIG_SOC_IMX31
-- 
1.7.4.1
