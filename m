From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Tue, 22 Aug 2017 21:20:56 +0800
Subject: [PATCH] arm64: defconfig: Enable hisilicon hibmc drm driver
Message-ID: <1503408056-177861-1-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable DRM_HISI_HIBMC as module for Hisilicon D03/D05 board.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index b4ca115..f4d2a8e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -365,6 +365,7 @@ CONFIG_DRM_TEGRA=m
 CONFIG_DRM_PANEL_SIMPLE=m
 CONFIG_DRM_I2C_ADV7511=m
 CONFIG_DRM_VC4=m
+CONFIG_DRM_HISI_HIBMC=m
 CONFIG_DRM_HISI_KIRIN=m
 CONFIG_DRM_MESON=m
 CONFIG_FB=y
-- 
1.8.3.1
