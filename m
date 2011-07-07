From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu,  7 Jul 2011 12:18:35 +0200
Subject: [PATCH 0/4] Cleanups for the mini2440 board
Message-ID: <1310033919-4245-1-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When compiling 3.0-rc6 for a mini2440, I noticed a few build warnings (some
seem to have been there for years!). Give the platform a little love...

Regards,

   Wolfram

Wolfram Sang (4):
  arm: plat-s3c24xx: dma: don't use uninitialized variable
  arm: plat-s3c24xx: dma: drop return codes in void function
  arm: mach-s3c2440: dma: fix section mismatch
  arm: mach-s3c2440: mini2440: fix section mismatch

 arch/arm/mach-s3c2440/dma.c           |    2 +-
 arch/arm/mach-s3c2440/mach-mini2440.c |    2 +-
 arch/arm/plat-s3c24xx/dma.c           |   12 +++---------
 3 files changed, 5 insertions(+), 11 deletions(-)

-- 
1.7.5.4
