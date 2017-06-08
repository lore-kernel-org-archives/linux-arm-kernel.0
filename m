From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 8 Jun 2017 20:07:33 +0530
Subject: [PATCH 2/2] ARM: davinci_all_defconfig: enable USB CDC NCM gadget
In-Reply-To: <20170608143733.30004-1-nsekhar@ti.com>
References: <20170608143733.30004-1-nsekhar@ti.com>
Message-ID: <20170608143733.30004-3-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable USB CDC NCM gadget module in davinci_all_defconfig
to make it easier to use it on these devices.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/configs/davinci_all_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index 1f1b4a795dc6..06e2e2a1a9be 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -186,6 +186,7 @@ CONFIG_USB_GADGET_DEBUG_FILES=y
 CONFIG_USB_GADGET_DEBUG_FS=y
 CONFIG_USB_ZERO=m
 CONFIG_USB_ETH=m
+CONFIG_USB_G_NCM=m
 CONFIG_USB_GADGETFS=m
 CONFIG_USB_MASS_STORAGE=m
 CONFIG_USB_G_SERIAL=m
-- 
2.9.0
