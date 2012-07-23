From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 23 Jul 2012 20:33:04 -0000
Subject: [GIT PULL 06/15] arm-soc: spi updates
In-Reply-To: <1343075561-17446-1-git-send-email-arnd@arndb.de>
References: <1343075561-17446-1-git-send-email-arnd@arndb.de>
Message-ID: <1343075561-17446-7-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 84a1caf1453c3d44050bd22db958af4a7f99315c:

  Linux 3.5-rc7 (2012-07-14 15:40:28 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git next/spi

for you to fetch changes up to 85644d2a8893d72d1869c6347e791902dd414288:

  Merge branch 'next/devel-samsung-spi' of git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung into next/spi (2012-07-21 23:12:15 +0200)

----------------------------------------------------------------

arm-soc: spi updates

These changes conceptually belong into the spi tree, but we decided to
put them into arm-soc to better deal with interdependencies with other
platform specific patches that are already there.

----------------------------------------------------------------

Arnd Bergmann (2):
      Merge branch 'next/devel-samsung-spi' of git://git.kernel.org/.../kgene/linux-samsung into next/spi
      Merge branch 'next/spi' into for-next

Kukjin Kim (1):
      Merge branch 'next/dt-samsung' into next/devel-samsung-spi

Mark Brown (4):
      spi/s3c64xx: Fix handling of errors in gpio_request()
      spi/s3c64xx: Put the /CS GPIO into output mode
      spi/s3c64xx: Convert to devm_request_and_ioremap()
      spi/s3c64xx: Expand S3C64XX_SPI_{DE,}ACT macros at call sites

 drivers/spi/spi-s3c64xx.c |   42 ++++++++++++------------------------------
 1 file changed, 12 insertions(+), 30 deletions(-)
