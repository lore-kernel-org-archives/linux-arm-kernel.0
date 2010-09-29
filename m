From: augulis.darius@gmail.com (Darius Augulis)
Date: Wed, 29 Sep 2010 22:30:38 +0300
Subject: [PATCH 0/9] ARM: S3C64XX: real6410 and mini6410 patches for next
Message-ID: <20100929192354.25307.40197.stgit@darius-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches add more features for real6410
and support for new board mini6410 from FriendlyARM.
All new devices are tested on both boards. Frame buffer
is tested with 4.3" and 7.0" LCD displays on mini6410 and
with 7.0" LCD display only on real6410.

---

Darius Augulis (9):
      ARM: S3C64XX: add frame buffer support for mach-real6410
      ARM: S3C64XX: add nand support for mach-real6410
      ARM: S3C64XX: add touchscreen support for mach-real6410
      ARM: S3C64XX: add USB host support for mach-real6410
      ARM: S3C64XX: add support for mach-mini6410
      ARM: S3C64XX: add nand support for mach-mini6410
      ARM: S3C64XX: add frame buffer support for mach-mini6410
      ARM: S3C64XX: add backlight control for mach-mini6410
      ARM: S3C64XX: add touchscreen support for mach-mini6410


 arch/arm/mach-s3c64xx/Kconfig         |   21 ++
 arch/arm/mach-s3c64xx/Makefile        |    1 
 arch/arm/mach-s3c64xx/mach-mini6410.c |  360 +++++++++++++++++++++++++++++++++
 arch/arm/mach-s3c64xx/mach-real6410.c |  198 ++++++++++++++++++
 4 files changed, 575 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/mach-s3c64xx/mach-mini6410.c

-- 
