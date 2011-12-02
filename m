From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 2 Dec 2011 13:57:57 +0800
Subject: [GIT PULL] mxs: fixes (round 2)
Message-ID: <20111202055756.GN711@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Please pull the fixes for mxs below.

Only patch 'arm: mx23: recognise stmp378x as mx23' has the tag
'Cc: stable at kernel.org', as all other 3 patches are cosmetic fixes.

-- 
Regards,
Shawn

The following changes since commit 5611cc4572e889b62a7b4c72a413536bf6a9c416:

  Linux 3.2-rc4 (2011-12-01 14:56:01 -0800)

are available in the git repository at:
  git://git.linaro.org/people/shawnguo/linux-2.6.git mxs/fixes

Dong Aisheng (1):
      ARM: mxs/tx28: add __initconst for fec pdata

Lauri Hintsala (1):
      ARM: mxs: fix machines' initializers order

Peter Rusko (1):
      ARM: mx28: LRADC macro rename

Wolfram Sang (1):
      arm: mx23: recognise stmp378x as mx23

 arch/arm/mach-mxs/include/mach/mx28.h  |    4 ++--
 arch/arm/mach-mxs/include/mach/mxs.h   |    1 +
 arch/arm/mach-mxs/mach-m28evk.c        |    2 +-
 arch/arm/mach-mxs/mach-stmp378x_devb.c |    2 +-
 arch/arm/mach-mxs/module-tx28.c        |    4 ++--
 5 files changed, 7 insertions(+), 6 deletions(-)
