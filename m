From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 10 Oct 2016 11:05:42 +0200
Subject: [PATCH v7 2/3] ARM: multi_v7: enable VGA bridge
In-Reply-To: <cover.60fc2fa7a6c5b5800b4e3a97b5598216817e0d9c.1476090316.git-series.maxime.ripard@free-electrons.com>
References: <cover.60fc2fa7a6c5b5800b4e3a97b5598216817e0d9c.1476090316.git-series.maxime.ripard@free-electrons.com>
Message-ID: <4c4e0bcf101f10b6641e8dfd75b21a3cff66b893.1476090316.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the RGB to VGA bridge driver in the defconfig

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+), 0 deletions(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 2c8665cd9dc5..aae732bd6681 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -567,6 +567,7 @@ CONFIG_DRM=y
 CONFIG_DRM_I2C_ADV7511=m
 # CONFIG_DRM_I2C_CH7006 is not set
 # CONFIG_DRM_I2C_SIL164 is not set
+CONFIG_DRM_DUMB_VGA_DAC=m
 CONFIG_DRM_NXP_PTN3460=m
 CONFIG_DRM_PARADE_PS8622=m
 CONFIG_DRM_NOUVEAU=m
-- 
git-series 0.8.10
