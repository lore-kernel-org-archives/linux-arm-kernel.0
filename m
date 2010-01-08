From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 8 Jan 2010 10:03:43 +0800
Subject: [GIT PULL] pxa: 5 more fixes for v2.6.33-rc2
Message-ID: <f17812d71001071803j5b8a51b7g10db53beb247f604@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

The following changes since commit 91a86a964f0773fdf466fe02577c8494ca8e2083:
  Eric Miao (1):
        [ARM] pxa/poodle: fix incorrect 'gpio_card_detect' of MMC

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git fix

Cyril Hrubis (1):
      [ARM] pxa: fix strange characters in zaurus gpio .desc

Eric Miao (2):
      [ARM] pxa: update pwm_backlight->notify() to include missed
'struct device *'
      [ARM] pxa: fix compiler warnings of unused variable 'id' in cpu_is_pxa9*()

Haojian Zhuang (2):
      [ARM] pxa: do not enable L2 after MMU is enabled
      [ARM] pxa: enable L2 if present in XSC3

 arch/arm/mach-pxa/include/mach/hardware.h |    9 +++------
 arch/arm/mach-pxa/magician.c              |    2 +-
 arch/arm/mach-pxa/palmld.c                |    2 +-
 arch/arm/mach-pxa/palmt5.c                |    2 +-
 arch/arm/mach-pxa/palmtc.c                |    2 +-
 arch/arm/mach-pxa/palmte2.c               |    2 +-
 arch/arm/mach-pxa/palmtreo.c              |    2 +-
 arch/arm/mach-pxa/palmtx.c                |    2 +-
 arch/arm/mach-pxa/palmz72.c               |    2 +-
 arch/arm/mach-pxa/spitz.c                 |    4 ++--
 arch/arm/mach-pxa/viper.c                 |    2 +-
 arch/arm/mm/cache-xsc3l2.c                |   11 +++++------
 arch/arm/mm/proc-xsc3.S                   |    7 +++++++
 13 files changed, 26 insertions(+), 23 deletions(-)
