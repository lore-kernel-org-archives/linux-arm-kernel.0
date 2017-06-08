From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu,  8 Jun 2017 18:10:37 +0200
Subject: [PATCH 26/35] ARM: tct_hammer_defconfig: Bring back lost (but wanted)
 options
In-Reply-To: <20170608160836.12196-1-krzk@kernel.org>
References: <20170608160836.12196-1-krzk@kernel.org>
Message-ID: <20170608161049.12421-26-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The config was not updated for some time so it needs updates to get the
same options as wanted initially:
 - SYSFS_DEPRECATED is now needed for SYSFS_DEPRECATED_V2;
 - USB_GADGET_S3C2410 was replaced by USB_S3C2410;

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/configs/tct_hammer_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/tct_hammer_defconfig b/arch/arm/configs/tct_hammer_defconfig
index a3494dde2bfa..71a2e0fb70f5 100644
--- a/arch/arm/configs/tct_hammer_defconfig
+++ b/arch/arm/configs/tct_hammer_defconfig
@@ -2,6 +2,7 @@
 # CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
+CONFIG_SYSFS_DEPRECATED=y
 CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
@@ -45,7 +46,7 @@ CONFIG_USB=y
 CONFIG_USB_MON=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_GADGET=y
-CONFIG_USB_GADGET_S3C2410=y
+CONFIG_USB_S3C2410=y
 CONFIG_USB_ETH=m
 CONFIG_EXT2_FS=y
 # CONFIG_DNOTIFY is not set
-- 
2.9.3
