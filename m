From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 07 Dec 2011 17:48:33 +0900
Subject: [GIT PULL] Samsung fixes-2 for v3.2
Message-ID: <03f401ccb4bd$00421090$00c631b0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Please pull samsung-fixes-2 for v3.2.
It includes small fixes for S3C64XX and update the Samsung field of MAINTAINERS.

If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit 5611cc4572e889b62a7b4c72a413536bf6a9c416:

  Linux 3.2-rc4 (2011-12-01 14:56:01 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git samsung-fixes-2

Heiko Stuebner (1):
      MAINTAINERS: Consolidate Samsung MAINTAINERS

Kukjin Kim (1):
      Merge branch 'next/topic-update-maintainer' into samsung-fixes-2

Mark Brown (5):
      MAINTAINERS: Add linux-samsung-soc mailing list for Samsung
      MAINTAINERS: Extend Samsung patterns to cover SPI and ASoC drivers
      ARM: S3C64XX: Remove extern from definition of framebuffer setup call
      ARM: S3C64XX: Add linux/export.h to dev-spi.c
      ARM: S3C64XX: Staticise s3c6400_sysclass

 MAINTAINERS                            |   27 +++++----------------------
 arch/arm/mach-s3c64xx/dev-spi.c        |    1 +
 arch/arm/mach-s3c64xx/s3c6400.c        |    2 +-
 arch/arm/mach-s3c64xx/setup-fb-24bpp.c |    2 +-
 4 files changed, 8 insertions(+), 24 deletions(-)
