From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Fri,  6 Feb 2015 18:42:47 +0100
Subject: [PATCH 1/1] ARM: exynos_defconfig: Enable HDMI support
Message-ID: <1423244567-24463-1-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many Exynos boards have an HDMI port so enable Exynos DRM HDMI support.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---

Exynos DRM HDMI has some issues that were fixed by Andrzej's [0] series.
So now is safe to HDMI support for Exynos boards.

[0]: https://lkml.org/lkml/2015/2/5/265

 arch/arm/configs/exynos_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 70e5d0bdb4e4..e44da52e5223 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -120,6 +120,7 @@ CONFIG_REGULATOR_S2MPS11=y
 CONFIG_REGULATOR_S5M8767=y
 CONFIG_REGULATOR_TPS65090=y
 CONFIG_DRM=y
+CONFIG_DRM_EXYNOS_HDMI=y
 CONFIG_DRM_BRIDGE=y
 CONFIG_DRM_PTN3460=y
 CONFIG_DRM_PS8622=y
-- 
2.1.3
