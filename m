From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 12 Jan 2012 02:35:27 +0900
Subject: [GIT PULL] Samsung fixes for v3.3
Message-ID: <4F0DC85F.2040204@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

Here is first fixes of Samsung stuff for v3.3.

Please pull that from following:
   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
samsung-fixes

If any problems, please let me know.

As a note, as we discussed, please kindly ignore previous 'pull request' 
of next-samsung-devel-samsung which maybe are in late/devel.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit e343a895a9f342f239c5e3c5ffc6c0b1707e6244:

   Merge tag 'for-linus' of 
git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost (2012-01-10 
18:04:27 -0800)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
samsung-fixes

Mark Brown (7):
       ARM: SAMSUNG: Guard against multiple inclusion of plat/dma.h
       ARM: SAMSUNG: dma-ops.h needs mach/dma.h
       ARM: SAMSUNG: Declare struct platform_device in plat/s3c64xx-spi.h
       ARM: S3C64XX: Remove unconditional power domain disables
       ARM: S3C64XX: Remove hsmmc1 from Cragganmore
       ARM: S3C64XX: Fix the memory mapped GPIOs on Cragganmore
       ARM: S3C64XX: Fix interrupt configuration for PCA935x on Cragganmore

Tushar Behera (1):
       ARM: EXYNOS: Invert VCLK polarity for framebuffer on ORIGEN

  arch/arm/mach-exynos/mach-origen.c               |    3 ++-
  arch/arm/mach-s3c64xx/include/mach/crag6410.h    |    1 +
  arch/arm/mach-s3c64xx/mach-crag6410.c            |   13 +++----------
  arch/arm/mach-s3c64xx/pm.c                       |   13 -------------
  arch/arm/plat-samsung/include/plat/dma-ops.h     |    1 +
  arch/arm/plat-samsung/include/plat/dma.h         |    6 +++++-
  arch/arm/plat-samsung/include/plat/s3c64xx-spi.h |    2 ++
  7 files changed, 14 insertions(+), 25 deletions(-)
