From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:14:50 +0200
Subject: [PATCH 2/3] arm64: defconfig: Enable CONFIG_SND_AUDIO_GRAPH_CARD
In-Reply-To: <cover.1526548323.git.horms+renesas@verge.net.au>
References: <cover.1526548323.git.horms+renesas@verge.net.au>
Message-ID: <ddf3fa8b8a16e076f247c115a73356b4b0d83a33.1526548323.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

CONFIG_SND_AUDIO_GRAPH_CARD is needed to use HDMI sound with video

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 53b3e3a56870..79b5b7d9ea55 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -440,6 +440,7 @@ CONFIG_SND_SOC_SAMSUNG=y
 CONFIG_SND_SOC_RCAR=m
 CONFIG_SND_SOC_AK4613=m
 CONFIG_SND_SIMPLE_CARD=m
+CONFIG_SND_AUDIO_GRAPH_CARD=m
 CONFIG_USB=y
 CONFIG_USB_OTG=y
 CONFIG_USB_XHCI_HCD=y
-- 
2.11.0
