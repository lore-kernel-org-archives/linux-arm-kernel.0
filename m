From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 8 Jul 2015 20:57:36 +0530
Subject: [PATCH 3/4] ARM: omap2plus_defconfig: enable support for TI CPTS
In-Reply-To: <cover.1436368740.git.nsekhar@ti.com>
References: <cover.1436368740.git.nsekhar@ti.com>
Message-ID: <0947246c3e1cda5c8ef56b9f0d60fec4ce6a0026.1436368740.git.nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CPTS module of CPSW IP enables timestamp synchronization
using PTP. Enable CPTS feature of CPSW driver.

Available on AM335x, AM437x and DRA7x SoCs.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 294059d5ef80..4cb1c11d83ad 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -169,6 +169,7 @@ CONFIG_SMSC911X=y
 # CONFIG_NET_VENDOR_STMICRO is not set
 CONFIG_TI_DAVINCI_EMAC=y
 CONFIG_TI_CPSW=y
+CONFIG_TI_CPTS=y
 # CONFIG_NET_VENDOR_VIA is not set
 # CONFIG_NET_VENDOR_WIZNET is not set
 CONFIG_AT803X_PHY=y
-- 
2.4.4.408.g16da57c
