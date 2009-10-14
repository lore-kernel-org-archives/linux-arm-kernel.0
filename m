From: tony@atomide.com (Tony Lindgren)
Date: Tue, 13 Oct 2009 17:13:52 -0700
Subject: [PATCH 2/6] omap: CONFIG_ISP1301_OMAP redefined in Beagle defconfig
In-Reply-To: <20091014001233.6116.84749.stgit@localhost>
References: <20091014001233.6116.84749.stgit@localhost>
Message-ID: <20091014001352.6116.3939.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sanjeev Premi <premi@ti.com>

The symbol CONFIG_ISP1301_OMAP was defined twice in the
defconfig. This was causing the warning:
arch/arm/configs/omap3_beagle_defconfig:972:warning:
 override: reassigning to symbol ISP1301_OMAP

Signed-off-by: Sanjeev Premi <premi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap3_beagle_defconfig |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/omap3_beagle_defconfig b/arch/arm/configs/omap3_beagle_defconfig
index 357d402..b3c8cce 100644
--- a/arch/arm/configs/omap3_beagle_defconfig
+++ b/arch/arm/configs/omap3_beagle_defconfig
@@ -969,7 +969,6 @@ CONFIG_USB_ETH_RNDIS=y
 #
 CONFIG_USB_OTG_UTILS=y
 # CONFIG_USB_GPIO_VBUS is not set
-# CONFIG_ISP1301_OMAP is not set
 CONFIG_TWL4030_USB=y
 # CONFIG_NOP_USB_XCEIV is not set
 CONFIG_MMC=y
