From: david@lechnology.com (David Lechner)
Date: Thu,  5 Jan 2017 22:33:45 -0600
Subject: [PATCH v2 2/5] ARM: davinci_all_defconfig: Enable PWM modules
In-Reply-To: <1483677228-2325-1-git-send-email-david@lechnology.com>
References: <1483677228-2325-1-git-send-email-david@lechnology.com>
Message-ID: <1483677228-2325-3-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables PWM and the TI ECAP and EHRWPM modules. These are used on LEGO
MINDSTORMS EV3.
---
 arch/arm/configs/davinci_all_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index a12e4c2..2b1967a 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -200,6 +200,9 @@ CONFIG_TI_EDMA=y
 CONFIG_MEMORY=y
 CONFIG_TI_AEMIF=m
 CONFIG_DA8XX_DDRCTL=y
+CONFIG_PWM=y
+CONFIG_PWM_TIECAP=m
+CONFIG_PWM_TIEHRPWM=m
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
-- 
2.7.4
