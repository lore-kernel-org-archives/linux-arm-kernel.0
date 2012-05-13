From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sun, 13 May 2012 09:41:10 +0900
Subject: [GIT PULL] Samsung boards update for v3.5
Message-ID: <4FAF0326.8000408@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull Samsung boards update for v3.5.
   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
next/board-samsung

As there were discussions, some exynos4 boards have been updated because 
current dt cannot support all features for current board files on exynos4.

Note, this should be merged after next/devel-samsung because some 
platform devices are defined in that.

If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit d48b97b403d23f6df0b990cee652bdf9a52337a3:

   Linux 3.4-rc6 (2012-05-06 15:07:32 -0700)

are available in the git repository at:
   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
next/board-samsung

Joonyoung Shim (1):
       ARM: EXYNOS: Add s3c-hsotg device support for NURI board

Lukasz Majewski (2):
       ARM: EXYNOS: Add s3c-hsotg device support for GONI board
       ARM: EXYNOS: Add s3c-hsotg device support for Universal C210 board

Marek Szyprowski (2):
       ARM: EXYNOS: Add DRM core device support for Universal C210 board
       ARM: EXYNOS: Add DRM core support for NURI board

Mark Brown (1):
       ARM: S3C64XX: Hook up new style regulator-regulator supplies on 
Cragganmore

Sachin Kamat (5):
       ARM: EXYNOS: Make BT platform data structure static in 
mach-origen.c file
       ARM: EXYNOS: Add DRM device to Origen
       ARM: EXYNOS: Add DRM device to SMDKV310
       ARM: EXYNOS: Add MFC device to SMDK4X12
       ARM: EXYNOS: Add FIMC device to SMDK4X12

Tushar Behera (1):
       ARM: EXYNOS: Increase framebuffer virtual size for origen

  arch/arm/mach-exynos/Kconfig               |   12 ++++++++
  arch/arm/mach-exynos/mach-nuri.c           |   42 
++++++++++++++++++++++++++-
  arch/arm/mach-exynos/mach-origen.c         |   35 ++++++++++++++++++++++-
  arch/arm/mach-exynos/mach-smdk4x12.c       |   16 ++++++++++
  arch/arm/mach-exynos/mach-smdkv310.c       |   30 +++++++++++++++++++
  arch/arm/mach-exynos/mach-universal_c210.c |   43 
++++++++++++++++++++++++++++
  arch/arm/mach-s3c64xx/mach-crag6410.c      |   18 +++++++++++
  arch/arm/mach-s5pv210/Kconfig              |    1 +
  arch/arm/mach-s5pv210/mach-goni.c          |    5 +++
  9 files changed, 200 insertions(+), 2 deletions(-)
