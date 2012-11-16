From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 16 Nov 2012 16:39:47 +0100
Subject: [PATCH 4/4] arm: orion5x: add DT related options in defconfig
In-Reply-To: <1353080388-4091-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353080388-4091-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353080388-4091-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Tested by: Maxime Hadjinlian <mhadjinlian@lacie.com>
---
 arch/arm/configs/orion5x_defconfig |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/orion5x_defconfig b/arch/arm/configs/orion5x_defconfig
index d0875ce..952430d 100644
--- a/arch/arm/configs/orion5x_defconfig
+++ b/arch/arm/configs/orion5x_defconfig
@@ -27,7 +27,7 @@ CONFIG_MACH_TS409=y
 CONFIG_MACH_WRT350N_V2=y
 CONFIG_MACH_TS78XX=y
 CONFIG_MACH_MV2120=y
-CONFIG_MACH_EDMINI_V2=y
+CONFIG_MACH_EDMINI_V2_DT=y
 CONFIG_MACH_D2NET=y
 CONFIG_MACH_BIGDISK=y
 CONFIG_MACH_NET2BIG=y
@@ -40,6 +40,7 @@ CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
+CONFIG_ARM_APPENDED_DTB=y
 CONFIG_FPE_NWFPE=y
 CONFIG_VFP=y
 CONFIG_NET=y
@@ -94,6 +95,7 @@ CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 # CONFIG_SERIAL_8250_PCI is not set
 CONFIG_SERIAL_8250_RUNTIME_UARTS=2
+CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_HW_RANDOM_TIMERIOMEM=m
 CONFIG_I2C=y
 # CONFIG_I2C_COMPAT is not set
-- 
1.7.9.5
