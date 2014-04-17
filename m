From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 17 Apr 2014 18:08:57 +0200
Subject: [PATCH 3/4] ARM: MVEBU: Add LaCie 2Big and 5Big Network v2
In-Reply-To: <1397750938-25381-1-git-send-email-andrew@lunn.ch>
References: <1397750938-25381-1-git-send-email-andrew@lunn.ch>
Message-ID: <1397750938-25381-4-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable building LaCie 2Big and 5Big Network v2 in the MVEBU v5 kernel.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/configs/mvebu_v5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/mvebu_v5_defconfig b/arch/arm/configs/mvebu_v5_defconfig
index 36484a37a1ca..58acd057e236 100644
--- a/arch/arm/configs/mvebu_v5_defconfig
+++ b/arch/arm/configs/mvebu_v5_defconfig
@@ -12,6 +12,7 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_ARCH_MVEBU=y
 CONFIG_MACH_KIRKWOOD=y
 CONFIG_MACH_T5325=y
+CONFIG_MACH_NETXBIG=y
 # CONFIG_CPU_FEROCEON_OLD_ID is not set
 CONFIG_PCI_MVEBU=y
 CONFIG_PREEMPT=y
-- 
1.9.2
