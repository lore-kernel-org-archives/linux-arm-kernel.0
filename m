From: eric@anholt.net (Eric Anholt)
Date: Thu, 31 Mar 2016 17:28:24 -0700
Subject: [PATCH 3/3] ARM: multi_v7_defconfig: Build in DWC2 USB support
In-Reply-To: <1459470504-5007-1-git-send-email-eric@anholt.net>
References: <1459470504-5007-1-git-send-email-eric@anholt.net>
Message-ID: <1459470504-5007-3-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows the Raspberry Pi 2 to be network booted from the
defconfig.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/configs/multi_v7_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index a913520..8079f7d 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -611,7 +611,7 @@ CONFIG_USB_STORAGE=y
 CONFIG_USB_MUSB_HDRC=m
 CONFIG_USB_MUSB_SUNXI=m
 CONFIG_USB_DWC3=y
-CONFIG_USB_DWC2=m
+CONFIG_USB_DWC2=y
 CONFIG_USB_CHIPIDEA=y
 CONFIG_USB_CHIPIDEA_UDC=y
 CONFIG_USB_CHIPIDEA_HOST=y
-- 
2.7.0
