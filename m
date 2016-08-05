From: kbeldan@baylibre.com (Karl Beldan)
Date: Fri,  5 Aug 2016 14:59:45 +0000
Subject: [PATCH v3 3/3] ARM: davinci_all_defconfig: enable SMSC ethernet PHY
In-Reply-To: <20160805145945.24315-1-kbeldan@baylibre.com>
References: <20160804144332.4841-1-kbeldan@baylibre.com>
 <20160805145945.24315-1-kbeldan@baylibre.com>
Message-ID: <20160805145945.24315-4-kbeldan@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LCDK embeds a LAN8710.

Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
---
 arch/arm/configs/davinci_all_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index cc3e702..d037d3d 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -88,6 +88,7 @@ CONFIG_BLK_DEV_SD=m
 CONFIG_NETDEVICES=y
 CONFIG_TUN=m
 CONFIG_LXT_PHY=y
+CONFIG_SMSC_PHY=y
 CONFIG_LSI_ET1011C_PHY=y
 CONFIG_NET_ETHERNET=y
 CONFIG_MII=y
-- 
2.9.0.rc1
