From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 22 Mar 2010 21:31:03 +0800
Subject: [GIT PULL] pxa: fixes for v2.6.34-rc2
Message-ID: <f17812d71003220631q226bc53aodb256140de2eb051@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

The following changes since commit 220bf991b0366cc50a94feede3d7341fa5710ee4:
  Linus Torvalds (1):
        Linux 2.6.34-rc2

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git fix

Dan Carpenter (1):
      pxa168fb: fix incorrect resource calculation

Daniel Mack (1):
      [ARM] pxa/raumfeld: fix button name

Eric Miao (3):
      [ARM] mmp: fix for variables in uncompress.h being discarded
      [ARM] pxa: remove unnecessary 'select FB_W100' from some platforms
      [ARM] pxa/sharpsl: add dependency of max1111 driver to sharpsl_pm

H Hartley Sweeten (2):
      [ARM] locomo: fix SPI register offset
      [ARM] locomo: fix unpaired spin_lock_irqsave

Huang Weiyi (1):
      [ARM] pxa/raumfeld: remove duplicated #include

Jonathan Cameron (2):
      [ARM] pxa: fix for variables in uncompress.h being discarded
      [ARM] pxa: remove spi cs gpio direction to avoid clash with driver

 arch/arm/common/locomo.c                    |   10 +++++-----
 arch/arm/mach-mmp/include/mach/uncompress.h |    5 ++++-
 arch/arm/mach-pxa/Kconfig                   |   11 +++++++----
 arch/arm/mach-pxa/imote2.c                  |    4 ----
 arch/arm/mach-pxa/include/mach/uncompress.h |   11 ++++++++---
 arch/arm/mach-pxa/raumfeld.c                |    4 +---
 arch/arm/mach-pxa/stargate2.c               |    5 -----
 drivers/video/pxa168fb.c                    |    2 +-
 8 files changed, 26 insertions(+), 26 deletions(-)
