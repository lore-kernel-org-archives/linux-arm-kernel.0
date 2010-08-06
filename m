From: augulis.darius@gmail.com (Darius Augulis)
Date: Fri, 06 Aug 2010 20:21:22 +0300
Subject: [PATCH v2 0/4] s3c: mach-real6410: patches for next merge window
Message-ID: <20100806172033.7695.62041.stgit@darius-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Several patches adding support for mach-real6410
and main platform devices. Please see inline patches
for detail description and changelogs.

---

Darius Augulis (4):
      s3c: add support for mach-real6410
      s3c: mach-real6410: add support for dm9000 ethernet
      s3c: mach-real6410: add sdhc device support
      s3c: mach-real6410: add nand support


 arch/arm/mach-s3c64xx/Kconfig         |   10 ++
 arch/arm/mach-s3c64xx/Makefile        |    1 
 arch/arm/mach-s3c64xx/mach-real6410.c |  193 +++++++++++++++++++++++++++++++++
 3 files changed, 204 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s3c64xx/mach-real6410.c

-- 
Signature
