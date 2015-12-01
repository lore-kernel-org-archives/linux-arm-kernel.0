From: andrew@lunn.ch (Andrew Lunn)
Date: Wed,  2 Dec 2015 00:33:30 +0100
Subject: [PATCH 3/5] ARM: config: Add orion5x to multi_v5_defconfig
In-Reply-To: <1449012812-9779-1-git-send-email-andrew@lunn.ch>
References: <1449012812-9779-1-git-send-email-andrew@lunn.ch>
Message-ID: <1449012812-9779-4-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that Orion5x is part of the v5 multiarch kernel enable it in the
multi_v5_defconfig.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/configs/multi_v5_defconfig | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/configs/multi_v5_defconfig b/arch/arm/configs/multi_v5_defconfig
index 920db77916b1..1f9ca4737ef6 100644
--- a/arch/arm/configs/multi_v5_defconfig
+++ b/arch/arm/configs/multi_v5_defconfig
@@ -14,6 +14,29 @@ CONFIG_MACH_KIRKWOOD=y
 CONFIG_ARCH_MXC=y
 CONFIG_MACH_IMX27_DT=y
 CONFIG_SOC_IMX25=y
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
 CONFIG_ARCH_U300=y
 CONFIG_PCI_MVEBU=y
 CONFIG_PREEMPT=y
-- 
2.6.2
