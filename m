From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 11 Jul 2011 15:26:24 +0800
Subject: [GIT PULL] pxa: cleanup for next
Message-ID: <CAMPhdO-BQjNxYauY9KEfszY11JmTqBWnbNnT1p1+RF=ZtyvNPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit fe0d42203cb5616eeff68b14576a0f7e2dd56625:

  Linux 3.0-rc6 (2011-07-04 15:56:24 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git cleanup

Dmitry Eremin-Solenikov (1):
      ARM: scoop: drop pcmcia_init callback

Eric Miao (1):
      ARM: pxa/saarb: make use of pxa3xx_map_io()

Igor Grinberg (4):
      ARM: pxa/cm-x300: fix V3020 RTC functionality
      ARM: pxa/cm-x300: GPIO cleanup
      ARM: pxa/cm-x300: minor style cleanup
      ARM: pxa/cm-x300: update cm_x300_defconfig

Jonathan Cameron (1):
      pcmcia: pxa2xx/trizeps4: remove unnecessary ifdefs

Philipp Zabel (4):
      ARM: pxa/magician: fix MAGICIAN_EGPIO_BASE, align with NR_BUILTIN_GPIO
      ARM: pxa/magician: use gpio arrays for backlight and global gpios
      ARM: pxa/hx4700: use gpio arrays for global gpios
      ARM: pxa/mioa701: use gpio arrays for global and gsm gpios

 arch/arm/configs/cm_x300_defconfig        |   18 ++------
 arch/arm/include/asm/hardware/scoop.h     |    1 -
 arch/arm/mach-pxa/cm-x300.c               |   58 +++++++++++-------------
 arch/arm/mach-pxa/hx4700.c                |   70 ++++++++---------------------
 arch/arm/mach-pxa/include/mach/magician.h |    3 +-
 arch/arm/mach-pxa/magician.c              |   57 +++++++++--------------
 arch/arm/mach-pxa/mioa701.c               |   70 ++++++----------------------
 arch/arm/mach-pxa/saarb.c                 |    2 +-
 drivers/pcmcia/pxa2xx_sharpsl.c           |    3 -
 drivers/pcmcia/pxa2xx_trizeps4.c          |    4 --
 10 files changed, 91 insertions(+), 195 deletions(-)
