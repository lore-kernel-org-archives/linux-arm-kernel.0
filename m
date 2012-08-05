From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Sun, 5 Aug 2012 17:38:27 +0200
Subject: [PATCH 0/2] ARM: S3C24XX: Fix compilation errors with 3.6-rc1
Message-ID: <201208051738.27728.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Small fallout from from the s3c64xx spi changes and from a dma change from
last year, that only surfaced after a gcc update.

Heiko Stuebner (2):
  ARM: S3C24XX: Add missing DMACH_DT_PROP
  ARM: S3C24XX: Fix s3c2410_dma_enqueue parameters

 arch/arm/mach-s3c24xx/include/mach/dma.h |    3 ++-
 arch/arm/plat-s3c24xx/dma.c              |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
1.7.2.3
