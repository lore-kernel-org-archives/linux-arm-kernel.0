From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 22 Aug 2011 01:42:51 +0200
Subject: [PATCH 0/4 v2] Miscellaneous s3c64xx fixes.
Message-ID: <mailman.92.1313970512.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series attempts to fix some issues I approached when working
on the s3c64xx platform. See descriptions of individual patches for more
details on each one.

All the patches are based on current master of the stable tree (v3.0.3).

Tomasz Figa (4):
  ARM: s3c64xx: DMA: Use S3C64XX_SDMA_SEL register name instead of
    numeric address.
  ARM: s3c64xx: Save/restore S3C64XX_SDMA_SEL on suspend/resume.
  ARM: s3c64xx: Save/restore S3C64XX_MODEM_MIFPCON on suspend/resume to
    preserve LCD bypass state.
  ARM: s3c64xx: Add support for synchronous clock operation.

 arch/arm/mach-s3c64xx/clock.c                 |    8 +++++++-
 arch/arm/mach-s3c64xx/dma.c                   |    2 +-
 arch/arm/mach-s3c64xx/include/mach/regs-sys.h |    5 ++++-
 arch/arm/mach-s3c64xx/pm.c                    |    4 ++++
 4 files changed, 16 insertions(+), 3 deletions(-)

-- 
1.7.6
