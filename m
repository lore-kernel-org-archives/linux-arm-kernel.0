From: afzal.mohd.ma@gmail.com (Afzal Mohammed)
Date: Wed, 11 Nov 2015 12:31:13 +0530
Subject: [PATCH] ARM: vf610m4: defconfig: enable printk time
Message-ID: <1447225273-2075-1-git-send-email-afzal.mohd.ma@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable PRINTK_TIME in Vybrid Cortex-M4 no-MMU defconfig.

Signed-off-by: Afzal Mohammed <afzal.mohd.ma@gmail.com>
---
 arch/arm/configs/vf610m4_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/vf610m4_defconfig b/arch/arm/configs/vf610m4_defconfig
index aeb2482c492e..2b124eed5f09 100644
--- a/arch/arm/configs/vf610m4_defconfig
+++ b/arch/arm/configs/vf610m4_defconfig
@@ -40,3 +40,4 @@ CONFIG_MFD_SYSCON=y
 # CONFIG_USB_SUPPORT is not set
 # CONFIG_MISC_FILESYSTEMS is not set
 # CONFIG_FTRACE is not set
+CONFIG_PRINTK_TIME=y
-- 
2.5.1
