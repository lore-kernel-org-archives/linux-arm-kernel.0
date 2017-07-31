From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 31 Jul 2017 17:03:32 +0200
Subject: [PATCH 01/10] ARM: shmobile: defconfig: Enable Ethernet AVB
In-Reply-To: <cover.1501511664.git.horms+renesas@verge.net.au>
References: <cover.1501511664.git.horms+renesas@verge.net.au>
Message-ID: <ff53e6064fd8badaf52ce5c13eeefd84c2e14332.1501511664.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Biju Das <biju.das@bp.renesas.com>

The iWave RZ/G1M Q7 SOM supports Gigabit Ethernet Phy (Micrel KSZ9031MNX).
Gigabit Ethernet support is available in Renesas AVB driver.
To increase hardware support enable the driver in the shmobile_defconfig
multiplatform configuration.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 3c66a422fb4d..d9929114d47b 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -83,6 +83,7 @@ CONFIG_NETDEVICES=y
 # CONFIG_NET_VENDOR_MICREL is not set
 # CONFIG_NET_VENDOR_NATSEMI is not set
 CONFIG_SH_ETH=y
+CONFIG_RAVB=y
 # CONFIG_NET_VENDOR_SEEQ is not set
 CONFIG_SMSC911X=y
 # CONFIG_NET_VENDOR_STMICRO is not set
-- 
2.1.4
