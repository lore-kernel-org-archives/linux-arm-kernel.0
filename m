From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 28 Aug 2013 10:40:29 +0900
Subject: [PATCH 1/2] ARM: shmobile: marzen: Select DRM_RCAR_DU in defconfig
In-Reply-To: <cover.1377652426.git.horms+renesas@verge.net.au>
References: <cover.1377652426.git.horms+renesas@verge.net.au>
Message-ID: <febedc9c9fe334dbb8810c47a178e6b7ff917d09.1377652426.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

A R-Car DU DRM device is registered for the Marzen board, select the
corresponding driver in its defconfig.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/marzen_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/marzen_defconfig b/arch/arm/configs/marzen_defconfig
index 82e4040..26f30be 100644
--- a/arch/arm/configs/marzen_defconfig
+++ b/arch/arm/configs/marzen_defconfig
@@ -85,6 +85,8 @@ CONFIG_GPIO_RCAR=y
 CONFIG_THERMAL=y
 CONFIG_RCAR_THERMAL=y
 CONFIG_SSB=y
+CONFIG_DRM=y
+CONFIG_DRM_RCAR_DU=y
 CONFIG_USB=y
 CONFIG_USB_RCAR_PHY=y
 CONFIG_MMC=y
-- 
1.8.3.2
