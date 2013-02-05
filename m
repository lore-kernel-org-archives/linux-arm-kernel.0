From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Tue,  5 Feb 2013 09:33:19 +0100
Subject: [PATCH 1/1] ARM: imx: configs: enable netfilter support
Message-ID: <1360053199-16229-1-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Netfilter packet filtering framework is useful for so many
use cases that most people will build kernels with it enabled.

So, it would probably make sense to have it enabled by default.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/configs/imx_v4_v5_defconfig |    1 +
 arch/arm/configs/imx_v6_v7_defconfig |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
index ebbfb27..516d03f 100644
--- a/arch/arm/configs/imx_v4_v5_defconfig
+++ b/arch/arm/configs/imx_v4_v5_defconfig
@@ -61,6 +61,7 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_INET_LRO is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
+CONFIG_NETFILTER=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 6966713..1107ae9 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -59,6 +59,7 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_LRO is not set
 CONFIG_IPV6=y
+CONFIG_NETFILTER=y
 # CONFIG_WIRELESS is not set
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
-- 
1.7.7.6
