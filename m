From: markus.mayer@linaro.org (Markus Mayer)
Date: Wed, 19 Jun 2013 16:08:49 -0700
Subject: [PATCH] ARM bcm281xx: Turn on socket & network support.
Message-ID: <1371683329-14827-1-git-send-email-markus.mayer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need this so an actual disk-based root file system will work.

Signed-off-by: Markus Mayer <markus.mayer@linaro.org>
Acked-by: Christian Daudt <csd@broadcom.com>
---
 arch/arm/configs/bcm_defconfig |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/configs/bcm_defconfig b/arch/arm/configs/bcm_defconfig
index e3bf2d6..63780b2 100644
--- a/arch/arm/configs/bcm_defconfig
+++ b/arch/arm/configs/bcm_defconfig
@@ -42,6 +42,18 @@ CONFIG_VFP=y
 CONFIG_NEON=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_PM_RUNTIME=y
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_PACKET_DIAG=y
+CONFIG_UNIX=y
+CONFIG_UNIX_DIAG=y
+CONFIG_NET_KEY=y
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+CONFIG_ARPD=y
+CONFIG_SYN_COOKIES=y
+CONFIG_TCP_MD5SIG=y
+CONFIG_IPV6=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_PROC_DEVICETREE=y
-- 
1.7.9.5
