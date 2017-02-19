From: plaes@plaes.org (Priit Laes)
Date: Sun, 19 Feb 2017 22:27:58 +0200
Subject: [PATCH 1/4] arm: defconfig: imx6: Added CONFIG_FHANDLE
In-Reply-To: <20170219202801.2082-1-plaes@plaes.org>
References: <20170219202801.2082-1-plaes@plaes.org>
Message-ID: <20170219202801.2082-2-plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_FHANDLE is a must-have for newer distributions with systemd
support (including Debian stable).

Signed-off-by: Priit Laes <plaes@plaes.org>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index cbe7faf..701db9a 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -1,5 +1,6 @@
 CONFIG_KERNEL_LZO=y
 CONFIG_SYSVIPC=y
+CONFIG_FHANDLE=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_IKCONFIG=y
-- 
2.9.3
