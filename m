From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 15:03:34 +0900
Subject: [PATCH 1/7] ARM: shmobile: lager: add gpio regulator support on
 defconfig
In-Reply-To: <cover.1387854925.git.horms+renesas@verge.net.au>
References: <cover.1387854925.git.horms+renesas@verge.net.au>
Message-ID: <081aaf4ab3ddaf66083b2fcd17b563a48112a232.1387854925.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/lager_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/lager_defconfig b/arch/arm/configs/lager_defconfig
index 35bff5e..064b7cc 100644
--- a/arch/arm/configs/lager_defconfig
+++ b/arch/arm/configs/lager_defconfig
@@ -89,6 +89,7 @@ CONFIG_THERMAL=y
 CONFIG_RCAR_THERMAL=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
+CONFIG_REGULATOR_GPIO=y
 CONFIG_DRM=y
 CONFIG_DRM_RCAR_DU=y
 # CONFIG_USB_SUPPORT is not set
-- 
1.8.4
