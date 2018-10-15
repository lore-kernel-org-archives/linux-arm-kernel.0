From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 15 Oct 2018 11:59:22 +0200
Subject: [PATCH 2/4] arm64: renesas_defconfig: Enable scu-simple-card driver
In-Reply-To: <20181015095924.25794-1-horms+renesas@verge.net.au>
References: <20181015095924.25794-1-horms+renesas@verge.net.au>
Message-ID: <20181015095924.25794-3-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the scu-simple-card which is used by
the R-Car E3 (r8a77990) based Ebisu board.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
N.B: This is targeted at the devel branch of the renesas tree
but not upstream where renesas_defconfig does not currently exist
---
 arch/arm64/configs/renesas_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/renesas_defconfig b/arch/arm64/configs/renesas_defconfig
index f8fca4a777da..54cf065ad84c 100644
--- a/arch/arm64/configs/renesas_defconfig
+++ b/arch/arm64/configs/renesas_defconfig
@@ -241,6 +241,7 @@ CONFIG_SND_SOC=y
 CONFIG_SND_SOC_RCAR=y
 CONFIG_SND_SOC_AK4613=y
 CONFIG_SND_SIMPLE_CARD=y
+CONFIG_SND_SIMPLE_SCU_CARD=y
 CONFIG_SND_AUDIO_GRAPH_CARD=y
 CONFIG_USB=y
 CONFIG_USB_OTG=y
-- 
2.11.0
