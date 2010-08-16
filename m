From: augulis.darius@gmail.com (Darius Augulis)
Date: Mon, 16 Aug 2010 20:43:18 +0300
Subject: [PATCH 0/2] s3c: mach-real6410 missing fixes
Message-ID: <20100816173905.14924.62664.stgit@darius-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two patches adding fixes that where in v2 of my
previous mach-real6410 patch series. These fixes are:
 * coding style errors reported by checkpatch.pl
 * irq flag in dm9000 pdata

---

Darius Augulis (2):
      s3c: mach-real6410: fix coding style errors
      s3c: mach-real6410: add IORESOURCE_IRQ_HIGHLEVEL flag to dm9000


 arch/arm/mach-s3c64xx/mach-real6410.c |  104 +++++++++++++++++----------------
 1 files changed, 52 insertions(+), 52 deletions(-)

-- 
