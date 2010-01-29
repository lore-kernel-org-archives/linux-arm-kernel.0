From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 29 Jan 2010 17:03:09 +0530
Subject: [PATCH] OMAP4: Enable L2 Cache
In-Reply-To: <1264764789-16025-2-git-send-email-santosh.shilimkar@ti.com>
References: <1264764789-16025-1-git-send-email-santosh.shilimkar@ti.com>
	<1264764789-16025-2-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1264764789-16025-3-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables L2 cache and associated Errata on the OMAP4430
SDP.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/configs/omap_4430sdp_defconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/omap_4430sdp_defconfig b/arch/arm/configs/omap_4430sdp_defconfig
index 3de640a..781770f 100644
--- a/arch/arm/configs/omap_4430sdp_defconfig
+++ b/arch/arm/configs/omap_4430sdp_defconfig
@@ -242,6 +242,8 @@ CONFIG_CPU_CP15_MMU=y
 # CONFIG_CPU_DCACHE_DISABLE is not set
 # CONFIG_CPU_BPREDICT_DISABLE is not set
 CONFIG_HAS_TLS_REG=y
+CONFIG_OUTER_CACHE=y
+CONFIG_CACHE_L2X0=y
 CONFIG_ARM_L1_CACHE_SHIFT=5
 # CONFIG_ARM_ERRATA_430973 is not set
 # CONFIG_ARM_ERRATA_458693 is not set
-- 
1.6.0.4
