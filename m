From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 29 Dec 2014 10:43:20 +0900
Subject: [PATCH 3/5] ARM: shmobile: defconfig: add MTD_BLOCK
In-Reply-To: <cover.1419808942.git.horms+renesas@verge.net.au>
References: <cover.1419808942.git.horms+renesas@verge.net.au>
Message-ID: <1df3396bd09baf4093f82a49f8a1a523277fdf82.1419808942.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

MTD_BLOOK is needed for accessing to SPI-FLASH

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reported-by: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Reported-by: Bui Duc Phuc ( Fukuda ) <bd-phuc@jinso.co.jp>
Reported-by: Nguyen Xuan Nui <nx-nui@jinso.co.jp>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index ad52868..a936a2e 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -56,6 +56,7 @@ CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_MTD=y
+CONFIG_MTD_BLOCK=y
 CONFIG_MTD_M25P80=y
 CONFIG_MTD_SPI_NOR=y
 CONFIG_EEPROM_AT24=y
-- 
2.1.3
