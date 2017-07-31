From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 31 Jul 2017 17:03:39 +0200
Subject: [PATCH 08/10] ARM: multi_v7_defconfig: Replace SND_SOC_RSRC_CARD by
 SND_SIMPLE_SCU_CARD
In-Reply-To: <cover.1501511664.git.horms+renesas@verge.net.au>
References: <cover.1501511664.git.horms+renesas@verge.net.au>
Message-ID: <883338aa8d3009d67868af53c6a7b8f5f1ff7e2d.1501511664.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

SND_SOC_RSRC_CARD was renamed SND_SIMPLE_SCU_CARD, hence update
multi_v7_defconfig.

Fixes: d12c6216c4a58f9f ("ASoC: rsrc-card: rename rsrc-card to simple-scu-card phase3")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/multi_v7_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 4d19c1b4b8e7..7fa1746970ec 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -650,7 +650,7 @@ CONFIG_SND_SOC_SMDK_WM8994_PCM=m
 CONFIG_SND_SOC_SNOW=m
 CONFIG_SND_SOC_SH4_FSI=m
 CONFIG_SND_SOC_RCAR=m
-CONFIG_SND_SOC_RSRC_CARD=m
+CONFIG_SND_SIMPLE_SCU_CARD=m
 CONFIG_SND_SUN4I_CODEC=m
 CONFIG_SND_SOC_TEGRA=m
 CONFIG_SND_SOC_TEGRA_RT5640=m
-- 
2.1.4
