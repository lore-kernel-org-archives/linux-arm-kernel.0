From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 24 Jul 2015 17:44:49 +0900
Subject: [PATCH 3/5] ARM: shmobile: defconfig: add Renesas DPCM Sound Card
In-Reply-To: <cover.1437727455.git.horms+renesas@verge.net.au>
References: <cover.1437727455.git.horms+renesas@verge.net.au>
Message-ID: <6cec276808bc0a4ac5fc3ab9e42a1b5d1e3e9cc4.1437727455.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch enables DPCM related sound card.
It is used for...
 - Sampline rate convert
 - CTU/MIXer

Note: you need to enable these settings on DTS file

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index c8e9caeb1c02..8da509327265 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -152,6 +152,7 @@ CONFIG_SND=y
 CONFIG_SND_SOC=y
 CONFIG_SND_SOC_SH4_FSI=y
 CONFIG_SND_SOC_RCAR=y
+CONFIG_SND_SOC_RSRC_CARD=y
 CONFIG_SND_SOC_AK4642=y
 CONFIG_SND_SOC_WM8978=y
 CONFIG_USB=y
-- 
2.1.4
