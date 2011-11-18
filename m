From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 18 Nov 2011 09:02:17 +0800
Subject: [GIT PULL v2] pxa: fixes for v3.2-rc1
Message-ID: <CAMPhdO8cJxSnTzNEeu+D-cOxQr7_OU6oOA55AhQbO6vHe0f11A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1ea6b8f48918282bdca0b32a34095504ee65bab5:

  Linux 3.2-rc1 (2011-11-07 16:16:02 -0800)

are available in the git repository at:
  git://github.com/ycmiao/pxa-linux.git fix

Eric Miao (1):
      ARM: pxa168/gplugd: add the correct SSP device

Haojian Zhuang (2):
      ARM: pxa: fix inconsistent CONFIG_USB_PXA27X
      ARM: mmp: fix build error on gpio

 arch/arm/configs/ezx_defconfig            |    2 +-
 arch/arm/configs/imote2_defconfig         |    2 +-
 arch/arm/configs/magician_defconfig       |    2 +-
 arch/arm/configs/zeus_defconfig           |    2 +-
 arch/arm/mach-mmp/gplugd.c                |    2 +-
 arch/arm/mach-mmp/include/mach/gpio-pxa.h |    2 +-
 arch/arm/mach-pxa/balloon3.c              |    2 +-
 arch/arm/mach-pxa/colibri-pxa320.c        |    2 +-
 arch/arm/mach-pxa/gumstix.c               |    2 +-
 arch/arm/mach-pxa/include/mach/palm27x.h  |    4 ++--
 arch/arm/mach-pxa/palm27x.c               |    4 ++--
 arch/arm/mach-pxa/palmtc.c                |    2 +-
 arch/arm/mach-pxa/vpac270.c               |    2 +-
 13 files changed, 15 insertions(+), 15 deletions(-)
