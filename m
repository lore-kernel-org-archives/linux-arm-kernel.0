From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 29 Sep 2013 00:12:33 +0400
Subject: [PATCH 2/2] ARM: shmobile: marzen: enable HPB-DMAC in defconfig
Message-ID: <201309290012.34072.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable HPB-DMAC driver in 'marzen_defconfig'.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against 'renesas-devel-20130927v2' tag of the 'renesas.git' repo.

 arch/arm/configs/marzen_defconfig |    2 ++
 1 file changed, 2 insertions(+)

Index: renesas/arch/arm/configs/marzen_defconfig
===================================================================
--- renesas.orig/arch/arm/configs/marzen_defconfig
+++ renesas/arch/arm/configs/marzen_defconfig
@@ -106,6 +106,8 @@ CONFIG_USB_STORAGE=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_GPIO=y
+CONFIG_DMADEVICES=y
+CONFIG_RCAR_HPB_DMAE=y
 CONFIG_UIO=y
 CONFIG_UIO_PDRV_GENIRQ=y
 # CONFIG_IOMMU_SUPPORT is not set
