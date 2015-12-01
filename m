From: andrew@lunn.ch (Andrew Lunn)
Date: Wed,  2 Dec 2015 00:33:32 +0100
Subject: [PATCH 5/5] ARM: mvebu: update v5 defconfig for Orion5x machines
In-Reply-To: <1449012812-9779-1-git-send-email-andrew@lunn.ch>
References: <1449012812-9779-1-git-send-email-andrew@lunn.ch>
Message-ID: <1449012812-9779-6-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that Orion5x is part of the multiarch kernel, add it to
mvebu_v5_defconfig.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/configs/mvebu_v5_defconfig | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/mvebu_v5_defconfig b/arch/arm/configs/mvebu_v5_defconfig
index d7c17864a1eb..af29780accdc 100644
--- a/arch/arm/configs/mvebu_v5_defconfig
+++ b/arch/arm/configs/mvebu_v5_defconfig
@@ -12,7 +12,29 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_MVEBU=y
 CONFIG_MACH_KIRKWOOD=y
-# CONFIG_CPU_FEROCEON_OLD_ID is not set
+CONFIG_ARCH_ORION5X=y
+CONFIG_MACH_DB88F5281=y
+CONFIG_MACH_RD88F5182=y
+CONFIG_MACH_RD88F5182_DT=y
+CONFIG_MACH_KUROBOX_PRO=y
+CONFIG_MACH_DNS323=y
+CONFIG_MACH_TS209=y
+CONFIG_MACH_TERASTATION_PRO2=y
+CONFIG_MACH_LINKSTATION_PRO=y
+CONFIG_MACH_LINKSTATION_LSCHL=y
+CONFIG_MACH_LINKSTATION_MINI=y
+CONFIG_MACH_LINKSTATION_LS_HGL=y
+CONFIG_MACH_TS409=y
+CONFIG_MACH_WRT350N_V2=y
+CONFIG_MACH_TS78XX=y
+CONFIG_MACH_MV2120=y
+CONFIG_MACH_D2NET_DT=y
+CONFIG_MACH_NET2BIG=y
+CONFIG_MACH_MSS2_DT=y
+CONFIG_MACH_WNR854T=y
+CONFIG_MACH_RD88F5181L_GE=y
+CONFIG_MACH_RD88F5181L_FXO=y
+CONFIG_MACH_RD88F6183AP_GE=y
 CONFIG_PCI_MVEBU=y
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
-- 
2.6.2
