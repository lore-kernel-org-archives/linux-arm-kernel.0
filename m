From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 18 Oct 2012 17:06:56 +0800
Subject: [PATCH 02/10] ARM: mmp: select pinctrl driver
In-Reply-To: <1350551224-12857-1-git-send-email-haojian.zhuang@gmail.com>
References: <1350551224-12857-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1350551224-12857-2-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pinctrl driver is necessary for MMP DT & MMP2 DT platforms.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 arch/arm/mach-mmp/Kconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mmp/Kconfig b/arch/arm/mach-mmp/Kconfig
index 7fddd01..c70c787 100644
--- a/arch/arm/mach-mmp/Kconfig
+++ b/arch/arm/mach-mmp/Kconfig
@@ -89,6 +89,7 @@ config MACH_MMP_DT
 	select CPU_PXA168
 	select CPU_PXA910
 	select USE_OF
+	select PINCTRL
 	help
 	  Include support for Marvell MMP2 based platforms using
 	  the device tree. Needn't select any other machine while
@@ -99,6 +100,7 @@ config MACH_MMP2_DT
 	depends on !CPU_MOHAWK
 	select CPU_MMP2
 	select USE_OF
+	select PINCTRL
 	help
 	  Include support for Marvell MMP2 based platforms using
 	  the device tree.
-- 
1.7.0.4
