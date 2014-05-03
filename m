From: andrew@lunn.ch (Andrew Lunn)
Date: Sat,  3 May 2014 20:35:13 +0200
Subject: [PATCH v2 4/5] ARM: mvebu: Add LaCie 2Big and 5Big Network v2
In-Reply-To: <1399142114-24257-1-git-send-email-andrew@lunn.ch>
References: <1399142114-24257-1-git-send-email-andrew@lunn.ch>
Message-ID: <1399142114-24257-5-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable building LaCie 2Big and 5Big Network v2 in the mvebu v5 kernel.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
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
2.0.0.rc0
