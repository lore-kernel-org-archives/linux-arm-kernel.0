From: andrew@lunn.ch (Andrew Lunn)
Date: Sat,  3 May 2014 20:30:19 +0200
Subject: [PATCH v2 9/9] ARM: multi_v5_defconfig: Enable sound modules needed
 for t5325
In-Reply-To: <1399141819-23924-1-git-send-email-andrew@lunn.ch>
References: <1399141819-23924-1-git-send-email-andrew@lunn.ch>
Message-ID: <1399141819-23924-10-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable simple-card and the CODEC.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/configs/multi_v5_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/multi_v5_defconfig b/arch/arm/configs/multi_v5_defconfig
index aa3dfb084fed..5ebfa8bf8509 100644
--- a/arch/arm/configs/multi_v5_defconfig
+++ b/arch/arm/configs/multi_v5_defconfig
@@ -11,7 +11,6 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_MVEBU=y
 CONFIG_MACH_KIRKWOOD=y
-CONFIG_MACH_T5325=y
 CONFIG_ARCH_MXC=y
 CONFIG_MACH_IMX25_DT=y
 CONFIG_MACH_IMX27_DT=y
@@ -108,6 +107,8 @@ CONFIG_SND=y
 CONFIG_SND_SOC=y
 CONFIG_SND_KIRKWOOD_SOC=y
 CONFIG_SND_KIRKWOOD_SOC_T5325=y
+CONFIG_SND_SOC_ALC5623=y
+CONFIG_SND_SIMPLE_CARD=y
 # CONFIG_ABX500_CORE is not set
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
-- 
2.0.0.rc0
