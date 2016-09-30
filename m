From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 30 Sep 2016 16:37:08 +0200
Subject: [PATCH v5 4/5] ARM: multi_v7: enable VGA bridge
In-Reply-To: <20160930143709.1388-1-maxime.ripard@free-electrons.com>
References: <20160930143709.1388-1-maxime.ripard@free-electrons.com>
Message-ID: <20160930143709.1388-5-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the RGB to VGA bridge driver in the defconfig

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 2c8665cd9dc5..22ef41afc658 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -567,6 +567,7 @@ CONFIG_DRM=y
 CONFIG_DRM_I2C_ADV7511=m
 # CONFIG_DRM_I2C_CH7006 is not set
 # CONFIG_DRM_I2C_SIL164 is not set
+CONFIG_DRM_RGB_TO_VGA=m
 CONFIG_DRM_NXP_PTN3460=m
 CONFIG_DRM_PARADE_PS8622=m
 CONFIG_DRM_NOUVEAU=m
-- 
2.9.3
