From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  4 Apr 2013 12:29:50 +0900
Subject: [RFC/PATCH 4/7] ARM: shmobile: Add mackerel to consolidated defconfig
In-Reply-To: <1365046193-19369-1-git-send-email-horms+renesas@verge.net.au>
References: <1365046193-19369-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1365046193-19369-5-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 8228e09..9b6219a 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -12,8 +12,10 @@ CONFIG_SLAB=y
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
 CONFIG_ARCH_SHMOBILE=y
+CONFIG_ARCH_SH7372=y
 CONFIG_ARCH_R8A7740=y
 CONFIG_ARCH_EMEV2=y
+CONFIG_MACH_MACKEREL=y
 CONFIG_MACH_ARMADILLO800EVA=y
 CONFIG_MACH_KZM9D=y
 # CONFIG_SH_TIMER_TMU is not set
@@ -58,6 +60,14 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_IPV6 is not set
 # CONFIG_WIRELESS is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_MTD=y
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_CFI=y
+CONFIG_MTD_CFI_ADV_OPTIONS=y
+CONFIG_MTD_CFI_INTELEXT=y
+CONFIG_MTD_PHYSMAP=y
+CONFIG_MTD_BLOCK2MTD=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_MD=y
@@ -116,7 +126,9 @@ CONFIG_LOGO=y
 # CONFIG_SND_ARM is not set
 CONFIG_SND_SOC_SH4_FSI=y
 CONFIG_USB=y
+CONFIG_USB_RENESAS_USBHS_HCD=y
 CONFIG_USB_RENESAS_USBHS=y
+CONFIG_USB_STORAGE=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_RENESAS_USBHS_UDC=y
 CONFIG_USB_ETH=y
-- 
1.7.10.4
