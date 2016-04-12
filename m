From: alim.akhtar@samsung.com (Alim Akhtar)
Date: Tue, 12 Apr 2016 18:20:58 +0530
Subject: [PATCH] arm64: defconfig: Enable PL330 DMA controller
Message-ID: <1460465458-23533-1-git-send-email-alim.akhtar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables PL330 DMA controller found on exynos7 SoCs.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 arch/arm64/configs/defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f705051..60e5886 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -230,6 +230,7 @@ CONFIG_RTC_DRV_SUN6I=y
 CONFIG_RTC_DRV_XGENE=y
 CONFIG_DMADEVICES=y
 CONFIG_QCOM_BAM_DMA=y
+CONFIG_PL330_DMA=y
 CONFIG_TEGRA20_APB_DMA=y
 CONFIG_RCAR_DMAC=y
 CONFIG_VFIO=y
-- 
1.7.10.4
