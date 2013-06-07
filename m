From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Fri, 7 Jun 2013 16:46:08 -0400
Subject: [PATCHv3 6/6] arm: omap2plus_defconfig: enable DRA752 thermal support
 by default
In-Reply-To: <1370637968-23299-1-git-send-email-eduardo.valentin@ti.com>
References: <1370637968-23299-1-git-send-email-eduardo.valentin@ti.com>
Message-ID: <1370637968-23299-7-git-send-email-eduardo.valentin@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make DRA752 thermal support enabled on omap2plus_defconfig

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: AnilKumar Ch <anilkumar@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 6e6c494..07aab0b 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -248,6 +248,7 @@ CONFIG_TI_SOC_THERMAL=y
 CONFIG_TI_THERMAL=y
 CONFIG_OMAP4_THERMAL=y
 CONFIG_OMAP5_THERMAL=y
+CONFIG_DRA752_THERMAL=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 # CONFIG_EXT3_FS_XATTR is not set
-- 
1.8.2.1.342.gfa7285d
