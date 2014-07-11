From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Fri, 11 Jul 2014 09:01:07 +0800
Subject: [GIT PULL v2][for 3.17] pull request from pxa git tree
Message-ID: <CAD6h2NTMLXxEi+uFz74B-de2y6-gggxhWt8yPS6593cuJxdMrw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd, Kevin,

Please help to merge the pull request from pxa git tree.

BTW, Laurent's fixing IO mapping patch will be merged by Olof directly.

Regards
Haojian

The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:

  Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/hzhuang1/linux.git
tags/pxa-for-v3.17-2

for you to fetch changes up to 5837391bbc7ab4307abf957e6cce0b83f7f9869a:

  ARM: pxa: fix typo 'CONFIG_SPI_PXA2XX_MASTER' (2014-07-11 08:50:53 +0800)

----------------------------------------------------------------
pxa for v3.17 v2

----------------------------------------------------------------
Andrew Ruder (2):
      ARM: pxa: correct errata number for PXA270
      ARM: pxa: call debug_ll_io_init for earlyprintk

Paul Bolle (1):
      ARM: pxa: fix typo 'CONFIG_SPI_PXA2XX_MASTER'

 arch/arm/mach-pxa/corgi.c   | 2 +-
 arch/arm/mach-pxa/generic.c | 1 +
 arch/arm/mach-pxa/sleep.S   | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)
