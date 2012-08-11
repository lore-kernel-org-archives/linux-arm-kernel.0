From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 11 Aug 2012 14:08:09 +0900
Subject: [PATCH 1/2] ARM: S3C64XX: Update configuration for WM5102 module
 on Cragganmore
In-Reply-To: <20120810100713.GH24328@opensource.wolfsonmicro.com>
References: <1344535549-4371-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <0db901cd76b4$7daf1730$790d4590$%kim@samsung.com>
 <20120810100713.GH24328@opensource.wolfsonmicro.com>
Message-ID: <0eff01cd777f$4c9d1f90$e5d75eb0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> On Fri, Aug 10, 2012 at 01:56:23PM +0900, Kukjin Kim wrote:
> 
> > Probably, this patch needs following?
> 
> > If you're ok, I will fix build error by above when I apply.
> 
> Yes, thanks.

Applied.

BTW, don't you need to enable your Cragganmore board in the defconfig?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.


From: Kukjin Kim <kgene.kim@samsung.com>
Subject: [PATCH] ARM: s3c6400_defconfig: enable more boards in defconfig

This enables all of s3c64xx boards in the s3c6400_defconfig.
In this time, MINI6410, REAL6410, and WLF_CRAGG_6410 are
added in the defconfig.

Cc: Darius Augulis <augulis.darius@gmail.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/configs/s3c6400_defconfig |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/s3c6400_defconfig
b/arch/arm/configs/s3c6400_defconfig
index ba6a515..3a186d6 100644
--- a/arch/arm/configs/s3c6400_defconfig
+++ b/arch/arm/configs/s3c6400_defconfig
@@ -9,11 +9,14 @@ CONFIG_ARCH_S3C64XX=y
 CONFIG_S3C_BOOT_ERROR_RESET=y
 CONFIG_MACH_SMDK6400=y
 CONFIG_MACH_ANW6410=y
+CONFIG_MACH_MINI6410=y
+CONFIG_MACH_REAL6410=y
 CONFIG_MACH_SMDK6410=y
 CONFIG_MACH_NCP=y
 CONFIG_MACH_HMT=y
 CONFIG_MACH_SMARTQ5=y
 CONFIG_MACH_SMARTQ7=y
+CONFIG_MACH_WLF_CRAGG_6410=y
 CONFIG_CPU_32v6K=y
 CONFIG_AEABI=y
 CONFIG_CMDLINE="console=ttySAC0,115200 root=/dev/ram init=/linuxrc
initrd=0x51000000,6M ramdisk_size=6144"
-- 
1.7.4.1
