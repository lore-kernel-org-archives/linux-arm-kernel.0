From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 15 Oct 2018 11:59:21 +0200
Subject: [PATCH 1/4] arm64: defconfig: Enable scu-simple-card driver
In-Reply-To: <20181015095924.25794-1-horms+renesas@verge.net.au>
References: <20181015095924.25794-1-horms+renesas@verge.net.au>
Message-ID: <20181015095924.25794-2-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the scu-simple-card which is used by
the R-Car E3 (r8a77990) based Ebisu board.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e6ec9858d33d..19f8cddce9ea 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -477,6 +477,7 @@ CONFIG_SND_SOC_RT5514=m
 CONFIG_SND_SOC_RT5514_SPI=m
 CONFIG_SND_SOC_RT5645=m
 CONFIG_SND_SIMPLE_CARD=m
+CONFIG_SND_SIMPLE_SCU_CARD=y
 CONFIG_SND_AUDIO_GRAPH_CARD=m
 CONFIG_I2C_HID=m
 CONFIG_USB=y
-- 
2.11.0
