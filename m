From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  1 Oct 2013 11:38:43 +0900
Subject: [PATCH 2/4] ARM: shmobile: lager: Select DRM_RCAR_DU in defconfig
In-Reply-To: <cover.1380514316.git.horms+renesas@verge.net.au>
References: <cover.1380514316.git.horms+renesas@verge.net.au>
Message-ID: <57601184cefb36db8c1959d277918bdabb6b1c64.1380514316.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

A R-Car DU DRM device is registered for the Lager board, select the
corresponding driver in its defconfig.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/lager_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/lager_defconfig b/arch/arm/configs/lager_defconfig
index e777ef2..35bff5e 100644
--- a/arch/arm/configs/lager_defconfig
+++ b/arch/arm/configs/lager_defconfig
@@ -89,6 +89,8 @@ CONFIG_THERMAL=y
 CONFIG_RCAR_THERMAL=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
+CONFIG_DRM=y
+CONFIG_DRM_RCAR_DU=y
 # CONFIG_USB_SUPPORT is not set
 CONFIG_MMC=y
 CONFIG_MMC_SDHI=y
-- 
1.8.4
