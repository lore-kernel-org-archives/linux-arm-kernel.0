From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 16 Nov 2009 14:19:11 -0600
Subject: [GIT PULL] pxa: fixes for v2.6.32-rc7
Message-ID: <f17812d70911161219o73c6e1a7v6d6f984db693763a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Here are some minor fixes for v2.6.32-rc7, please consider pull.

The following changes since commit 156171c71a0dc4bce12b4408bb1591f8fe32dc1a:
  Linus Torvalds (1):
        Linux 2.6.32-rc7

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git fix

Eric Miao (1):
      [ARM] pxa: fix incorrect mfp_to_gpio() conversion

Marc Zyngier (1):
      [ARM] pxa: fix interrupts number calculation when
CONFIG_PXA_HAVE_ISA_IRQS=y

Marek Vasut (1):
      [ARM] pxa/colibri: fix AC97 ifdefs and add missing include

Paul Parsons (1):
      [ARM] pxa/hx4700: fix hx4700 touchscreen pressure values

Roel Kluin (2):
      [ARM] pxa: fix missing underscores in mfp-pxa910.h
      [ARM] pxa: ensure mfp is in correct range in mfp_{read,write}

 arch/arm/mach-mmp/include/mach/mfp-pxa910.h  |    2 +-
 arch/arm/mach-pxa/colibri-pxa320.c           |    4 +++-
 arch/arm/mach-pxa/hx4700.c                   |    2 +-
 arch/arm/mach-pxa/include/mach/entry-macro.S |    1 +
 arch/arm/plat-pxa/include/plat/mfp.h         |    2 +-
 arch/arm/plat-pxa/mfp.c                      |    4 ++--
 6 files changed, 9 insertions(+), 6 deletions(-)
