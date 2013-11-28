From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 28 Nov 2013 18:08:50 +0900
Subject: [PATCH 11/16] ARM: shmobile: bockw: Enable CONFIG_PACKET in defconfig
In-Reply-To: <cover.1385629477.git.horms+renesas@verge.net.au>
References: <cover.1385629477.git.horms+renesas@verge.net.au>
Message-ID: <66d0a50ea15a5a05372e9f8bb0fa7bdc873e4179.1385629477.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_PACKET is required for the ISC dhcpd daemon function.
This change brings the bockw defconfig into line with
other shmobile defconfigs.

Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/configs/bockw_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/bockw_defconfig b/arch/arm/configs/bockw_defconfig
index 01721faf..191decb 100644
--- a/arch/arm/configs/bockw_defconfig
+++ b/arch/arm/configs/bockw_defconfig
@@ -32,6 +32,7 @@ CONFIG_VFP=y
 # CONFIG_SUSPEND is not set
 CONFIG_PM_RUNTIME=y
 CONFIG_NET=y
+CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
 CONFIG_IP_PNP=y
-- 
1.8.4
