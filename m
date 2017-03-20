From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 20 Mar 2017 10:39:56 +0100
Subject: [GIT PULL] ARM: OXNAS SoC update for 4.12
Message-ID: <cd2d94ef-9098-6e4e-ed65-74191d45370e@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear arm-soc maintainers,

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  https://github.com/OXNAS/linux.git tags/oxnas-arm-soc-for-4.12

for you to fetch changes up to b44327d198b4f1bbebaf83f714cde450471de644:

  ARM: oxnas: remove redundant select CPU_V6K (2017-03-20 10:13:45 +0100)

----------------------------------------------------------------
- Fix OX820 Kconfig

----------------------------------------------------------------
Masahiro Yamada (1):
      ARM: oxnas: remove redundant select CPU_V6K

 arch/arm/mach-oxnas/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-oxnas/Kconfig b/arch/arm/mach-oxnas/Kconfig
index 8fa4557..e3610c5 100644
--- a/arch/arm/mach-oxnas/Kconfig
+++ b/arch/arm/mach-oxnas/Kconfig
@@ -28,7 +28,6 @@ config MACH_OX820
 	depends on ARCH_MULTI_V6
 	select ARM_GIC
 	select DMA_CACHE_RWFO if SMP
-	select CPU_V6K
 	select HAVE_SMP
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
