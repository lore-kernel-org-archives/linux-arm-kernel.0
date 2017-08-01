From: david@lechnology.com (David Lechner)
Date: Tue,  1 Aug 2017 17:11:50 -0500
Subject: [PATCH v2 4/4] ARM: davinci_all_defconfig: enable tinydrm and ST7586
In-Reply-To: <1501625510-16727-1-git-send-email-david@lechnology.com>
References: <1501625510-16727-1-git-send-email-david@lechnology.com>
Message-ID: <1501625510-16727-5-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the tinydrm and ST7586 panel modules used by the display
on LEGO MINDSTORMS EV3.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/configs/davinci_all_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index 06e2e2a..27d9720 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -143,6 +143,8 @@ CONFIG_VIDEO_ADV7343=m
 CONFIG_DRM=m
 CONFIG_DRM_TILCDC=m
 CONFIG_DRM_DUMB_VGA_DAC=m
+CONFIG_DRM_TINYDRM=m
+CONFIG_TINYDRM_ST7586=m
 CONFIG_FB=y
 CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_DA8XX=y
-- 
2.7.4
