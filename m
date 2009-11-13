From: tony@atomide.com (Tony Lindgren)
Date: Thu, 12 Nov 2009 16:09:21 -0800
Subject: [PATCH 11/14] omap3: evm: make HSMMC driver built-in
In-Reply-To: <20091113000444.9034.41293.stgit@localhost>
References: <20091113000444.9034.41293.stgit@localhost>
Message-ID: <20091113000921.9034.57644.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sriram <srk@ti.com>

For ease of use it is preferrable to build in HSMMC driver
rather than build it as kernel module. This patches updates
default configuration for omap3evm to reflect this change.

Signed-off-by: Sriramakrishnan <srk@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap3_evm_defconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/omap3_evm_defconfig b/arch/arm/configs/omap3_evm_defconfig
index d5ff477..36c99e0 100644
--- a/arch/arm/configs/omap3_evm_defconfig
+++ b/arch/arm/configs/omap3_evm_defconfig
@@ -1126,7 +1126,7 @@ CONFIG_MMC_BLOCK_BOUNCE=y
 #
 # CONFIG_MMC_SDHCI is not set
 # CONFIG_MMC_OMAP is not set
-CONFIG_MMC_OMAP_HS=m
+CONFIG_MMC_OMAP_HS=y
 # CONFIG_MMC_SPI is not set
 # CONFIG_MEMSTICK is not set
 # CONFIG_ACCESSIBILITY is not set
