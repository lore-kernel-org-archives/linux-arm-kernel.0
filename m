From: rmallon@gmail.com (Ryan Mallon)
Date: Wed, 11 Sep 2013 10:15:21 +1000
Subject: [GIT PULL] ep93xx-devel for 3.12
Message-ID: <522FB619.90603@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:

  Linux 3.11-rc1 (2013-07-14 15:18:27 -0700)

are available in the git repository at:

  git://github.com/RyanMallon/linux-ep93xx.git tags/ep93xx-devel-for-3.12

for you to fetch changes up to 0e98a32f8773993da65ab4759b0c5ba362119ebb:

  arm: ep93xx: use soc bus (2013-07-19 10:08:15 +1000)

----------------------------------------------------------------
H Hartley Sweeten (1):
      arm: ep93xx: use soc bus

 arch/arm/mach-ep93xx/Kconfig                 |    1 +
 arch/arm/mach-ep93xx/core.c                  |  108 +++++++++++++++++++++++++-
 arch/arm/mach-ep93xx/include/mach/platform.h |    3 +-
 3 files changed, 110 insertions(+), 2 deletions(-)
