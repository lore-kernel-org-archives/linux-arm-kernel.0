From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 6 May 2010 14:24:50 +0800
Subject: [GIT PULL] pxa: fixes for v2.6.34-rc5
Message-ID: <x2wf17812d71005052324y7df93398r446a3b9817cbe078@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

The following changes since commit 01bf0b64579ead8a82e7cfc32ae44bc667e7ad0f:
  Linus Torvalds (1):
        Linux 2.6.34-rc5

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git fix

Daniel Mack (1):
      [ARM] pxa/raumfeld: fix button name

Haojian Zhuang (2):
      [ARM] pxa: update cpuid pattern for pxa9xx in head.S
      [ARM] pxa: fix the incorrect cpu_is_pxa950()

Igor Grinberg (1):
      [ARM] pxa: add missing new line to regs-u2d.h

Jakob Viketoft (1):
      [ARM] pxa/colibri: fix missing #include <mach/mfp.h> in colibri.h

Pavel Machek (1):
      [ARM] pxa/spitz: fix On/off key name to fix warning during boot

Stefan Schmidt (1):
      [ARM] pxa/imote2: Fix iMote2 defconfig

Wolfram Sang (1):
      [ARM] pxa/viper: fix timeout usage for I2C

 arch/arm/boot/compressed/head.S           |   10 +--
 arch/arm/configs/imote2_defconfig         |  172 +++++++++++------------------
 arch/arm/mach-pxa/include/mach/colibri.h  |    1 +
 arch/arm/mach-pxa/include/mach/hardware.h |    2 +-
 arch/arm/mach-pxa/include/mach/regs-u2d.h |    3 +-
 arch/arm/mach-pxa/raumfeld.c              |    5 +-
 arch/arm/mach-pxa/spitz.c                 |    2 +-
 arch/arm/mach-pxa/viper.c                 |    5 +-
 8 files changed, 79 insertions(+), 121 deletions(-)
