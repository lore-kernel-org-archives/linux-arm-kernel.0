From: guodong.xu@linaro.org (Guodong Xu)
Date: Fri, 19 Aug 2016 23:42:05 +0800
Subject: [PATCH 1/4] arm64: defconfig: Enable HiSilicon kirin drm,
 adv7533 for HiKey
In-Reply-To: <1471621328-21102-1-git-send-email-guodong.xu@linaro.org>
References: <1471621328-21102-1-git-send-email-guodong.xu@linaro.org>
Message-ID: <1471621328-21102-2-git-send-email-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable HiSilicon kirin drm driver for HiKey: CONFIG_DRM_HISI_KIRIN
Enable adv7511/adv7533 for HiKey: CONFIG_DRM_I2C_ADV7511

Build these components as modules.

Signed-off-by: Xinliang Liu <xinliang.liu@linaro.org>
Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 76bfaa7..e27f086 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -276,6 +276,8 @@ CONFIG_DRM=m
 CONFIG_DRM_NOUVEAU=m
 CONFIG_DRM_TEGRA=m
 CONFIG_DRM_PANEL_SIMPLE=m
+CONFIG_DRM_I2C_ADV7511=m
+CONFIG_DRM_HISI_KIRIN=m
 CONFIG_FB=y
 CONFIG_FB_ARMCLCD=y
 CONFIG_BACKLIGHT_GENERIC=m
-- 
1.9.1
