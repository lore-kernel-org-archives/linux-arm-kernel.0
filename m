From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  1 Oct 2013 11:38:44 +0900
Subject: [PATCH 3/4] ARM: shmobile: bockw defconfig: add Sound support
In-Reply-To: <cover.1380514316.git.horms+renesas@verge.net.au>
References: <cover.1380514316.git.horms+renesas@verge.net.au>
Message-ID: <dca778f1e470494019e41e9eef073eb981a64380.1380514316.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/bockw_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/bockw_defconfig b/arch/arm/configs/bockw_defconfig
index e7e9494..b38cd10 100644
--- a/arch/arm/configs/bockw_defconfig
+++ b/arch/arm/configs/bockw_defconfig
@@ -91,6 +91,10 @@ CONFIG_VIDEO_RCAR_VIN=y
 CONFIG_VIDEO_ML86V7667=y
 CONFIG_SPI=y
 CONFIG_SPI_SH_HSPI=y
+CONFIG_SOUND=y
+CONFIG_SND=y
+CONFIG_SND_SOC=y
+CONFIG_SND_SOC_RCAR=y
 CONFIG_USB=y
 CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
 CONFIG_USB_EHCI_HCD=y
-- 
1.8.4
