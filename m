From: r.sricharan@ti.com (Sricharan R)
Date: Fri, 7 Mar 2014 17:46:15 +0530
Subject: [RFC PATCH 8/9] arm: dra: Enable dma crossbar support on dra7xx
In-Reply-To: <1394194576-23741-1-git-send-email-r.sricharan@ti.com>
References: <1394194576-23741-1-git-send-email-r.sricharan@ti.com>
Message-ID: <1394194576-23741-9-git-send-email-r.sricharan@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable dma crossbar support on dra7xx

Signed-off-by: Sricharan R <r.sricharan@ti.com>
---
 arch/arm/configs/omap2plus_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 3a0b53d..1cf8277 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -295,3 +295,4 @@ CONFIG_LIBCRC32C=y
 CONFIG_FONTS=y
 CONFIG_FONT_8x8=y
 CONFIG_FONT_8x16=y
+CONFIG_OMAP_DMA_CROSSBAR=y
-- 
1.7.9.5
