From: rmallon@gmail.com (Ryan Mallon)
Date: Thu, 27 Sep 2012 09:21:10 +1000
Subject: [GIT PULL] ep93xx-fixes for 3.7
Message-ID: <50638DE6.8010801@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 0d7614f09c1ebdbaa1599a5aba7593f147bf96ee:

  Linux 3.6-rc1 (2012-08-02 16:38:10 -0700)

are available in the git repository at:

  git://github.com/RyanMallon/linux-ep93xx.git tags/ep93xx-fixes-for-3.7

for you to fetch changes up to e4d4a9027877593d80d71e8a93e39670b1881627:

  ARM: ep93xx: Move ts72xx.h out of include/mach (2012-09-17 09:09:08 +1000)

----------------------------------------------------------------
Arnd Bergmann (1):
      ARM: ep93xx: use __iomem pointers for MMIO

Axel Lin (1):
      ARM: ep93xx: Fix build error due to 'SZ_32M' undeclared

Ryan Mallon (1):
      ARM: ep93xx: Move ts72xx.h out of include/mach

 arch/arm/mach-ep93xx/adssphere.c                 |    1 +
 arch/arm/mach-ep93xx/gesbc9312.c                 |    1 +
 arch/arm/mach-ep93xx/ts72xx.c                    |   12 ++++++------
 arch/arm/mach-ep93xx/{include/mach => }/ts72xx.h |   10 +++++-----
 4 files changed, 13 insertions(+), 11 deletions(-)
 rename arch/arm/mach-ep93xx/{include/mach => }/ts72xx.h (89%)
