From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 24 Jul 2015 17:44:50 +0900
Subject: [PATCH 4/5] ARM: multi_v7_defconfig: add Renesas DPCM Sound Card
In-Reply-To: <cover.1437727455.git.horms+renesas@verge.net.au>
References: <cover.1437727455.git.horms+renesas@verge.net.au>
Message-ID: <9afa6c4980492f0305c57e6e8acb4161960df6f4.1437727455.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch enables Renesas DPCM related sound card.
It is used for...
 - Sampline rate convert
 - CTU/MIXer

Note: you need to enable these settings on DTS file

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 77f4b76d16e9..c2eae2abf190 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -462,6 +462,7 @@ CONFIG_SND_ATMEL_SOC=m
 CONFIG_SND_ATMEL_SOC_WM8904=m
 CONFIG_SND_SOC_SH4_FSI=m
 CONFIG_SND_SOC_RCAR=m
+CONFIG_SND_SOC_RSRC_CARD=m
 CONFIG_SND_SOC_TEGRA=m
 CONFIG_SND_SOC_TEGRA_RT5640=m
 CONFIG_SND_SOC_TEGRA_WM8753=m
-- 
2.1.4
