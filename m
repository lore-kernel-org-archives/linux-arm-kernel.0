From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 17 Apr 2014 18:08:58 +0200
Subject: [PATCH 4/4] ARM: MULTI_V5: Enable LaCie 2Big and 5Big Network v2
In-Reply-To: <1397750938-25381-1-git-send-email-andrew@lunn.ch>
References: <1397750938-25381-1-git-send-email-andrew@lunn.ch>
Message-ID: <1397750938-25381-5-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable building LaCie 2Big and 5Big Network v2 in the multi v5 kernel.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/configs/multi_v5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v5_defconfig b/arch/arm/configs/multi_v5_defconfig
index aa3dfb084fed..cd3f1016ece3 100644
--- a/arch/arm/configs/multi_v5_defconfig
+++ b/arch/arm/configs/multi_v5_defconfig
@@ -12,6 +12,7 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_ARCH_MVEBU=y
 CONFIG_MACH_KIRKWOOD=y
 CONFIG_MACH_T5325=y
+CONFIG_MACH_NETXBIG=y
 CONFIG_ARCH_MXC=y
 CONFIG_MACH_IMX25_DT=y
 CONFIG_MACH_IMX27_DT=y
-- 
1.9.2
