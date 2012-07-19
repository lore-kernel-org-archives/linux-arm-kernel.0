From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 20 Jul 2012 07:39:56 +0900
Subject: [GIT PULL] Samsung devel-spi for v3.6
Message-ID: <195001cd65ff$6c3a5340$44aef9c0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof

Please pull devel-spi for samsung stuff for v3.6 from:
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git next/devel-samsung-spi

You may think that 'since this is including only samsung spi stuff, so this should be sent to
upstream via spi tree', yeah right. But in this time, would be helpful to us if they could be sent
via arm-soc, samsung tree for avoiding useless conflicts. Because samsung-dt-spi branch touches the
same driver and it is already in arm-soc tree.

If any problems, please kindly let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit f9ed561ebd71f7a9a3238507ef9082862e2cbc9a:

  Merge branch 'next/dt-samsung' into next/devel-samsung-spi (2012-07-19 14:20:32 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git next/devel-samsung-spi

Mark Brown (4):
      spi/s3c64xx: Fix handling of errors in gpio_request()
      spi/s3c64xx: Put the /CS GPIO into output mode
      spi/s3c64xx: Convert to devm_request_and_ioremap()
      spi/s3c64xx: Expand S3C64XX_SPI_{DE,}ACT macros at call sites

 drivers/spi/spi-s3c64xx.c |   42 ++++++++++++------------------------------
 1 files changed, 12 insertions(+), 30 deletions(-)
