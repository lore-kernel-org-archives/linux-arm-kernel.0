From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 8 Jan 2012 11:44:10 +0800
Subject: [GIT PULL] mxs: board support for 3.3
Message-ID: <20120108034408.GB19721@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

As I promised to Lauri, I will send his board support for 3.3.  I know
even if it gets pulled, it will go to 'late/*' which is not guaranteed
to be sent for 3.3.  But anyway, here it is.  Please consider to pull.

Regards,
Shawn

The following changes since commit 33e1ef2fd56569528d1c22fe37e9c020eadd91be:

  Merge remote-tracking branch 'arm-soc/mxs/saif' into mxs/board (2012-01-06 23:06:12 +0800)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git mxs/boards

Lauri Hintsala (1):
      ARM: mxs: Add initial support for Bluegiga APX4 Development Kit

Shawn Guo (1):
      ARM: mxs: detect SoC by checking CHIPID register

 arch/arm/mach-mxs/Kconfig                   |   16 ++
 arch/arm/mach-mxs/Makefile                  |    1 +
 arch/arm/mach-mxs/include/mach/digctl.h     |    1 +
 arch/arm/mach-mxs/include/mach/mxs.h        |   29 ++--
 arch/arm/mach-mxs/include/mach/uncompress.h |   13 +-
 arch/arm/mach-mxs/mach-apx4devkit.c         |  245 +++++++++++++++++++++++++++
 6 files changed, 285 insertions(+), 20 deletions(-)
 create mode 100644 arch/arm/mach-mxs/mach-apx4devkit.c
