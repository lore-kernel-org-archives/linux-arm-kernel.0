From: tony@atomide.com (Tony Lindgren)
Date: Thu, 8 Mar 2012 10:04:41 -0800
Subject: [GIT PULL] few more fixes for v3.3-rc6
Message-ID: <20120308180441.GT12083@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd & Olof,

Here are few more fixes for the current -rc cycle if there's
still enough time to get them in.

Regards,

Tony


The following changes since commit 192cfd58774b4d17b2fe8bdc77d89c2ef4e0591d:
  Linus Torvalds (1):
        Linux 3.3-rc6

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes

Cousson, Benoit (1):
      ARM: OMAP: irqs: Fix NR_IRQS value to handle PRCM interrupts

R Sricharan (1):
      ARM: OMAP2+: Fix module build errors with CONFIG_OMAP4_ERRATA_I688

Rajendra Nayak (1):
      ARM: OMAP2+: Remove apply_uV constraints for fixed regulator

Vaibhav Hiremath (1):
      ARM: OMAP: id: Add missing break statement in omap3xxx_check_revision

 arch/arm/mach-omap2/id.c               |    1 +
 arch/arm/mach-omap2/omap4-common.c     |    2 ++
 arch/arm/mach-omap2/twl-common.c       |    1 -
 arch/arm/plat-omap/include/plat/irqs.h |   10 +++++++++-
 4 files changed, 12 insertions(+), 2 deletions(-)
