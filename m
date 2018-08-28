From: jbrunet@baylibre.com (Jerome Brunet)
Date: Tue, 28 Aug 2018 14:27:35 +0200
Subject: [PATCH] arm64: defconfig: enable modules for amlogic s400 sound card
Message-ID: <20180828122735.28919-1-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Compile the necessary drivers as modules, including codecs, for the
s400 sound card.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/configs/defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f67e8d5e93ad..6b1daea53bd3 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -464,6 +464,7 @@ CONFIG_SND_SOC_ROCKCHIP_I2S=m
 CONFIG_SND_SOC_ROCKCHIP_SPDIF=m
 CONFIG_SND_SOC_ROCKCHIP_RT5645=m
 CONFIG_SND_SOC_RK3399_GRU_SOUND=m
+CONFIG_SND_MESON_AXG_SOUND_CARD=m
 CONFIG_SND_SOC_SAMSUNG=y
 CONFIG_SND_SOC_RCAR=m
 CONFIG_SND_SOC_AK4613=m
@@ -475,6 +476,9 @@ CONFIG_SND_SOC_RT5514_SPI=m
 CONFIG_SND_SOC_RT5645=m
 CONFIG_SND_SIMPLE_CARD=m
 CONFIG_SND_AUDIO_GRAPH_CARD=m
+CONFIG_SND_SOC_ES7134=m
+CONFIG_SND_SOC_ES7241=m
+CONFIG_SND_SOC_TAS571X=m
 CONFIG_I2C_HID=m
 CONFIG_USB=y
 CONFIG_USB_OTG=y
-- 
2.17.1
