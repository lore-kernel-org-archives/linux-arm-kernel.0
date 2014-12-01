From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 1 Dec 2014 14:24:40 +0100
Subject: [PATCH 4/4] ARM: at91/defconfig: add DM9000 to at91_dt
In-Reply-To: <eb931e7c5534cd949ba61307f0380826e62ceb2c.1417440150.git.nicolas.ferre@atmel.com>
References: <eb931e7c5534cd949ba61307f0380826e62ceb2c.1417440150.git.nicolas.ferre@atmel.com>
Message-ID: <a810207c369c57acefc5624ff7dfeb4d92de52ff.1417440150.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This chip is present on at91sam9261ek board: add it to the at91_dt_defconfig.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/configs/at91_dt_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index 6ccf937a60f2..a67375f24b21 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -80,6 +80,7 @@ CONFIG_BLK_DEV_SD=y
 CONFIG_NETDEVICES=y
 CONFIG_MACB=y
 # CONFIG_NET_VENDOR_BROADCOM is not set
+CONFIG_DM9000=y
 # CONFIG_NET_VENDOR_FARADAY is not set
 # CONFIG_NET_VENDOR_INTEL is not set
 # CONFIG_NET_VENDOR_MARVELL is not set
-- 
2.1.3
