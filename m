From: david@lechnology.com (David Lechner)
Date: Mon,  9 Jan 2017 10:11:39 -0600
Subject: [RESEND 2/3] ARM: davinci_all_defconfig: Enable PWM modules
In-Reply-To: <1483978300-403-1-git-send-email-david@lechnology.com>
References: <1483978300-403-1-git-send-email-david@lechnology.com>
Message-ID: <1483978300-403-3-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables PWM and the TI ECAP and EHRWPM modules. These are used on LEGO
MINDSTORMS EV3.

Signed-off-by: David Lechner <david@lechnology.com>
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
