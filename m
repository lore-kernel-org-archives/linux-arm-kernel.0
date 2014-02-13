From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Feb 2014 14:19:35 +0900
Subject: [PATCH] ARM: shmobile: koelsch: Enable SDHI in defconfig
Message-ID: <1392268775-2072-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/koelsch_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/koelsch_defconfig b/arch/arm/configs/koelsch_defconfig
index 9561139..f4e221f 100644
--- a/arch/arm/configs/koelsch_defconfig
+++ b/arch/arm/configs/koelsch_defconfig
@@ -73,6 +73,8 @@ CONFIG_THERMAL=y
 CONFIG_RCAR_THERMAL=y
 # CONFIG_HID is not set
 # CONFIG_USB_SUPPORT is not set
+CONFIG_MMC=y
+CONFIG_MMC_SDHI=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 # CONFIG_IOMMU_SUPPORT is not set
-- 
1.8.5.2
