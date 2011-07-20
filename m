From: ajaykumar.rs@samsung.com (Ajay Kumar)
Date: Wed, 20 Jul 2011 19:02:28 +0530
Subject: [PATCH 0/3] ARM: SAMSUNG: Cleanup mach/regs-fb.h from various machines
Message-ID: <1311168751-30336-1-git-send-email-ajaykumar.rs@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset cleans up mach/regs-fb.h from S3C64XX, S5PC100, and S5PV210.
plat/regs-fb-v4.h is used instead to provide the same support.

Display testing done on SMDK6410, SMDKC100 and SMDKV210.
For other machines, its compile tested.

o To Kukjin Kim, Jingoo Han, Marek Szyprowski.
  ARM: S5PC100: Cleanup mach/regs-fb.h from mach-s5pc100
  ARM: S5PV210: Cleanup mach/regs-fb.h from mach-s5pv210
  ARM: S3C64XX: Cleanup mach/regs-fb.h from mach-s3c64xx

 arch/arm/mach-s3c64xx/include/mach/regs-fb.h |   21 -----
 arch/arm/mach-s3c64xx/mach-anw6410.c         |    2 +-
 arch/arm/mach-s3c64xx/mach-crag6410.c        |    2 +-
 arch/arm/mach-s3c64xx/mach-hmt.c             |    2 +-
 arch/arm/mach-s3c64xx/mach-mini6410.c        |    2 +-
 arch/arm/mach-s3c64xx/mach-ncp.c             |    2 +-
 arch/arm/mach-s3c64xx/mach-real6410.c        |    2 +-
 arch/arm/mach-s3c64xx/mach-smartq5.c         |    2 +-
 arch/arm/mach-s3c64xx/mach-smartq7.c         |    2 +-
 arch/arm/mach-s3c64xx/mach-smdk6410.c        |    2 +-
 arch/arm/mach-s3c64xx/setup-fb-24bpp.c       |    1 -
 arch/arm/mach-s5pc100/include/mach/regs-fb.h |  105 --------------------------
 arch/arm/mach-s5pc100/mach-smdkc100.c        |    2 +-
 arch/arm/mach-s5pc100/setup-fb-24bpp.c       |    1 -
 arch/arm/mach-s5pv210/include/mach/regs-fb.h |   21 -----
 arch/arm/mach-s5pv210/mach-aquila.c          |    2 +-
 arch/arm/mach-s5pv210/mach-goni.c            |    2 +-
 arch/arm/mach-s5pv210/mach-smdkv210.c        |    2 +-
 arch/arm/mach-s5pv210/setup-fb-24bpp.c       |    1 -
 19 files changed, 13 insertions(+), 163 deletions(-)
 delete mode 100644 arch/arm/mach-s3c64xx/include/mach/regs-fb.h
 delete mode 100644 arch/arm/mach-s5pc100/include/mach/regs-fb.h
 delete mode 100644 arch/arm/mach-s5pv210/include/mach/regs-fb.h
