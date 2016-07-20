From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 20 Jul 2016 11:58:56 +0200
Subject: [PATCH v2 6/7] ARM: multi_v7: enable VGA bridge
In-Reply-To: <20160720095857.12297-1-maxime.ripard@free-electrons.com>
References: <20160720095857.12297-1-maxime.ripard@free-electrons.com>
Message-ID: <20160720095857.12297-7-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the RGB to VGA bridge driver in the defconfig

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 26c35f8b1dd6..edfbd27c9971 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -566,6 +566,7 @@ CONFIG_DRM=y
 CONFIG_DRM_I2C_ADV7511=m
 # CONFIG_DRM_I2C_CH7006 is not set
 # CONFIG_DRM_I2C_SIL164 is not set
+CONFIG_DRM_DUMB_VGA=m
 CONFIG_DRM_NXP_PTN3460=m
 CONFIG_DRM_PARADE_PS8622=m
 CONFIG_DRM_NOUVEAU=m
-- 
2.9.0
