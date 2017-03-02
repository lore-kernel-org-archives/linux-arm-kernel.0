From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu,  2 Mar 2017 16:39:58 +0100
Subject: [PATCH 02/11] drm/meson: Add missing HDMI register
In-Reply-To: <1488469207-523-1-git-send-email-narmstrong@baylibre.com>
References: <1488469207-523-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1488469207-523-3-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing VPU HDMI register.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_registers.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/meson/meson_registers.h b/drivers/gpu/drm/meson/meson_registers.h
index 6adf9c1..2847381 100644
--- a/drivers/gpu/drm/meson/meson_registers.h
+++ b/drivers/gpu/drm/meson/meson_registers.h
@@ -1319,6 +1319,7 @@
 #define VPU_MISC_CTRL 0x2740
 #define VPU_ISP_GCLK_CTRL0 0x2741
 #define VPU_ISP_GCLK_CTRL1 0x2742
+#define VPU_HDMI_FMT_CTRL 0x2743
 #define VPU_VDIN_ASYNC_HOLD_CTRL 0x2743
 #define VPU_VDISP_ASYNC_HOLD_CTRL 0x2744
 #define VPU_VPUARB2_ASYNC_HOLD_CTRL 0x2745
-- 
1.9.1
