From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 26 May 2014 21:29:51 +0200
Subject: [PATCHv4 4/4] ARM: multi_v5: Enable LaCie 2Big and 5Big Network v2
In-Reply-To: <1401132591-26305-1-git-send-email-andrew@lunn.ch>
References: <1401132591-26305-1-git-send-email-andrew@lunn.ch>
Message-ID: <1401132591-26305-5-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable building LaCie 2Big and 5Big Network v2 in the multi v5 kernel.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
v3->v4
  Add G762 fan controller
---
 arch/arm/configs/multi_v5_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v5_defconfig b/arch/arm/configs/multi_v5_defconfig
index 5ebfa8bf8509..018bef9fa7e8 100644
--- a/arch/arm/configs/multi_v5_defconfig
+++ b/arch/arm/configs/multi_v5_defconfig
@@ -11,6 +11,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_MVEBU=y
 CONFIG_MACH_KIRKWOOD=y
+CONFIG_MACH_NETXBIG=y
 CONFIG_ARCH_MXC=y
 CONFIG_MACH_IMX25_DT=y
 CONFIG_MACH_IMX27_DT=y
@@ -94,6 +95,7 @@ CONFIG_POWER_RESET=y
 CONFIG_POWER_RESET_GPIO=y
 CONFIG_POWER_RESET_QNAP=y
 CONFIG_SENSORS_ADT7475=y
+CONFIG_SENSORS_G762=y
 CONFIG_SENSORS_LM63=y
 CONFIG_SENSORS_LM75=y
 CONFIG_SENSORS_LM85=y
-- 
2.0.0.rc2
