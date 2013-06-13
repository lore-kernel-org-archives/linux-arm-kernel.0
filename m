From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Jun 2013 16:00:11 +0900
Subject: [PATCH 3/3] ARM: shmobile: bockw defconfig: add MMCIF support
In-Reply-To: <1371106811-25223-1-git-send-email-horms+renesas@verge.net.au>
References: <1371106811-25223-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1371106811-25223-4-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/bockw_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/bockw_defconfig b/arch/arm/configs/bockw_defconfig
index 55e00ff..845f5cd 100644
--- a/arch/arm/configs/bockw_defconfig
+++ b/arch/arm/configs/bockw_defconfig
@@ -94,6 +94,7 @@ CONFIG_USB_STORAGE=y
 CONFIG_USB_RCAR_PHY=y
 CONFIG_MMC=y
 CONFIG_MMC_SDHI=y
+CONFIG_MMC_SH_MMCIF=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_RX8581=y
 CONFIG_UIO=y
-- 
1.8.2.1
