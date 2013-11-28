From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 28 Nov 2013 18:08:53 +0900
Subject: [PATCH 14/16] ARM: shmobile: marzen: enable HPB-DMAC in defconfig
In-Reply-To: <cover.1385629477.git.horms+renesas@verge.net.au>
References: <cover.1385629477.git.horms+renesas@verge.net.au>
Message-ID: <96c4f31f955bd35e33bae1e11a5e614f5c7163cd.1385629477.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Enable HPB-DMAC driver in 'marzen_defconfig'.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/marzen_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/marzen_defconfig b/arch/arm/configs/marzen_defconfig
index 9ce38f6..dd4aced 100644
--- a/arch/arm/configs/marzen_defconfig
+++ b/arch/arm/configs/marzen_defconfig
@@ -103,6 +103,8 @@ CONFIG_USB_STORAGE=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_GPIO=y
+CONFIG_DMADEVICES=y
+CONFIG_RCAR_HPB_DMAE=y
 CONFIG_UIO=y
 CONFIG_UIO_PDRV_GENIRQ=y
 # CONFIG_IOMMU_SUPPORT is not set
-- 
1.8.4
