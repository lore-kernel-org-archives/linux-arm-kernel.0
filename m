From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 12 Jun 2013 06:08:37 +0900
Subject: [GIT PULL 1/6] s3c24xx arch
Message-ID: <51B791D5.5050005@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:

   Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/s3c24xx-arch-1

for you to fetch changes up to a496bda66201e855f6b5d5d701d8bd65b9178700:

   ARM: S3C24XX: remove obsolete s3c2412 specific dma settings 
(2013-05-21 01:01:41 +0900)

----------------------------------------------------------------
update dma part for s3c24xx

----------------------------------------------------------------
Heiko Stuebner (3):
       ARM: S3C24XX: split s3c2412 spi dma channels
       ARM: S3C24XX: dma-s3c2443 - do not write into arbitary bits
       ARM: S3C24XX: remove obsolete s3c2412 specific dma settings

  arch/arm/mach-s3c24xx/dma-s3c2412.c              | 56 
+++++++-----------------
  arch/arm/mach-s3c24xx/dma-s3c2443.c              |  3 +-
  arch/arm/mach-s3c24xx/dma.c                      |  3 --
  arch/arm/plat-samsung/include/plat/dma-s3c24xx.h |  5 ---
  4 files changed, 17 insertions(+), 50 deletions(-)
