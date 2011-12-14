From: tony@atomide.com (Tony Lindgren)
Date: Wed, 14 Dec 2011 13:53:05 -0800
Subject: [GIT PULL] two omap fixes for v3.2-rc5
Message-ID: <20111214215305.GN32251@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd & Olof,

Please pull two regression fixes for the -rc series from:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes

Regards,

Tony


The following changes since commit dc47ce90c3a822cd7c9e9339fe4d5f61dcb26b50:
  Linus Torvalds (1):
        Linux 3.2-rc5

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes

Felipe Contreras (1):
      ARM: OMAP: rx51: fix USB

Jarkko Nikula (1):
      ARM: OMAP: mcbsp: Fix possible memory corruption

 arch/arm/mach-omap2/board-rx51-peripherals.c |    2 +-
 arch/arm/mach-omap2/mcbsp.c                  |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)
