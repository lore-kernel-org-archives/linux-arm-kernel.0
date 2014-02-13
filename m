From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Feb 2014 17:04:34 +0900
Subject: [PATCH 2/4] ARM: shmobile: lager: add sound support on defconfig
In-Reply-To: <cover.1392276997.git.horms+renesas@verge.net.au>
References: <cover.1392276997.git.horms+renesas@verge.net.au>
Message-ID: <90bdadf5b05be16e7ba663ba8b9e42d20dcef861.1392276997.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/lager_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/lager_defconfig b/arch/arm/configs/lager_defconfig
index 3e7e0ae..b17f487 100644
--- a/arch/arm/configs/lager_defconfig
+++ b/arch/arm/configs/lager_defconfig
@@ -105,6 +105,10 @@ CONFIG_VIDEO_RCAR_VIN=y
 CONFIG_VIDEO_ADV7180=y
 CONFIG_DRM=y
 CONFIG_DRM_RCAR_DU=y
+CONFIG_SOUND=y
+CONFIG_SND=y
+CONFIG_SND_SOC=y
+CONFIG_SND_SOC_RCAR=y
 # CONFIG_USB_SUPPORT is not set
 CONFIG_MMC=y
 CONFIG_MMC_SDHI=y
-- 
1.8.5.2
