From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 28 Nov 2013 18:08:52 +0900
Subject: [PATCH 13/16] ARM: shmobile: marzen: Do not enable CONFIG_SMC911X in
 defconfig
In-Reply-To: <cover.1385629477.git.horms+renesas@verge.net.au>
References: <cover.1385629477.git.horms+renesas@verge.net.au>
Message-ID: <f3a3d2cfb7fb10e2e23d02abb5459ff974f2c8bd.1385629477.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_SMC911X is not needed by marzen.
It appears to have been accidently enabled as well
as CONFIG_SMSC911X which is needed by marzen.

Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/configs/marzen_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/marzen_defconfig b/arch/arm/configs/marzen_defconfig
index a423bad..9ce38f6 100644
--- a/arch/arm/configs/marzen_defconfig
+++ b/arch/arm/configs/marzen_defconfig
@@ -59,7 +59,6 @@ CONFIG_NETDEVICES=y
 # CONFIG_NET_VENDOR_MICREL is not set
 # CONFIG_NET_VENDOR_NATSEMI is not set
 # CONFIG_NET_VENDOR_SEEQ is not set
-CONFIG_SMC911X=y
 CONFIG_SMSC911X=y
 # CONFIG_NET_VENDOR_STMICRO is not set
 # CONFIG_WLAN is not set
-- 
1.8.4
