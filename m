From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Fri, 4 Jul 2014 21:14:46 +0800
Subject: [GIT PULL][for v3.17] pull request from pxa git tree
Message-ID: <CAD6h2NSmFxLah64ukoopLXrJ=D5hjBWNLONPUOA=K+jOg4EWEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof, Kevin,

Please help to merge the pull request from pxa git tree.

Best Regards
Haojian

The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:

  Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/hzhuang1/linux.git
tags/pxa-for-v3.17

for you to fetch changes up to 282b37e19cc1d3302ad28f92671aa6093685e075:

  ARM: pxa: fix typo 'CONFIG_SPI_PXA2XX_MASTER' (2014-07-04 20:52:09 +0800)

----------------------------------------------------------------
pxa for v3.17

----------------------------------------------------------------
Andrew Ruder (2):
      ARM: pxa: correct errata number for PXA270
      ARM: pxa: call debug_ll_io_init for earlyprintk

Haojian Zhuang (1):
      ARM: pxa: remove unnecessary pxa3xx io mapping

Paul Bolle (1):
      ARM: pxa: fix typo 'CONFIG_SPI_PXA2XX_MASTER'

 arch/arm/mach-pxa/corgi.c   | 2 +-
 arch/arm/mach-pxa/generic.c | 9 ++++++++-
 arch/arm/mach-pxa/sleep.S   | 2 +-
 3 files changed, 10 insertions(+), 3 deletions(-)
