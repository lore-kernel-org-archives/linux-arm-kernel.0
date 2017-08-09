From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 9 Aug 2017 19:32:49 +0530
Subject: [PATCH v2 3/3] ARM: omap2plus_defconfig: enable DP83867 phy driver
In-Reply-To: <cover.1502284400.git.nsekhar@ti.com>
References: <cover.1502284400.git.nsekhar@ti.com>
Message-ID: <c4cc6b8d3fc2c6d900c0e43e32af0bd89228f5a9.1502284400.git.nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

TI's DP83867 phy is used on DRA72x EVM rev C and DRA71x
EVMs. Enable support for it in omap2plus_defconfig.

The driver is built into the kernel to help NFS booting.

Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index a120ae816260..d4afa2ca2537 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -170,6 +170,7 @@ CONFIG_TI_CPTS=y
 # CONFIG_NET_VENDOR_WIZNET is not set
 CONFIG_AT803X_PHY=y
 CONFIG_DP83848_PHY=y
+CONFIG_DP83867_PHY=y
 CONFIG_MICREL_PHY=y
 CONFIG_SMSC_PHY=y
 CONFIG_PPP=m
-- 
2.9.0
