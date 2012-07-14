From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 14 Jul 2012 07:35:28 +0000
Subject: ARM: Samsung SoC fixes for 3.5-rc
Message-ID: <201207140735.29019.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Here's a second set of fixes for this -rc, all for the samsung platforms.

	Arnd
---
The following changes since commit bd0a521e88aa7a06ae7aabaed7ae196ed4ad867a:

  Linux 3.5-rc6 (2012-07-07 17:23:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/fixes-for-linus

for you to fetch changes up to df4732abf91fa394bea95d912aff718ef5e2be5d:

  Merge branch 'v3.5-samsung-fixes-2' of git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung into fixes (2012-07-14 09:14:35 +0200)

----------------------------------------------------------------

ARM: Samsung SoC fixes for 3.5-rc

----------------------------------------------------------------
Arnd Bergmann (1):
      Merge branch 'v3.5-samsung-fixes-2' of git://git.kernel.org/.../kgene/linux-samsung into fixes

Marek Szyprowski (2):
      ARM: EXYNOS: read initial state of power domain from hw registers
      ARM: EXYNOS: register devices in 'need_restore' state for pm_domains

Sylwester Nawrocki (2):
      ARM: S3C24XX: Correct AC97 clock control bit for S3C2440
      ARM: S3C24XX: Correct CAMIF interrupt definitions

Todd Poynor (1):
      ARM: SAMSUNG: fix race in s3c_adc_start for ADC

Tushar Behera (1):
      ARM: SAMSUNG: Update default rate for xusbxti clock

 arch/arm/mach-exynos/pm_domains.c     |   13 +++++++++----
 arch/arm/mach-s3c24xx/clock-s3c2440.c |    2 +-
 arch/arm/plat-samsung/adc.c           |    8 +++++---
 arch/arm/plat-samsung/devs.c          |    3 ++-
 arch/arm/plat-samsung/s5p-clock.c     |    1 +
 5 files changed, 18 insertions(+), 9 deletions(-)
