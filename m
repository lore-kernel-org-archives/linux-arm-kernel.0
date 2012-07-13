From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 14 Jul 2012 08:38:55 +0900
Subject: [GIT PULL] Samsung fixes-2 for v3.5
Message-ID: <11fd01cd6150$aaf8ea50$00eabef0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull second samsung fixes for v3.5 from:
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
v3.5-samsung-fixes-2

Correcting some values, fixing race and fixing regarding pm_domains are
included in.

If any problems, please kindly let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit bd0a521e88aa7a06ae7aabaed7ae196ed4ad867a:

  Linux 3.5-rc6 (2012-07-07 17:23:56 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
v3.5-samsung-fixes-2

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
