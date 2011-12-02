From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 02 Dec 2011 10:45:07 +0000
Subject: [GIT PULL] Fixes for the irqchip-consolidation tree
Message-ID: <4ED8AC33.8050502@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

Please consider pulling two patches from my irqchip-consolidation 
branch, which fix two typos I introduced (fixes courtesy of Axel Lin).

Thanks,

	M.

The following changes since commit 11f1c5de7be06bbb51363002ebc4d00edc2677df:
  Jamie Iles (1):
        ARM: VIC: remove non MULTI_IRQ_HANDLER support

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irqchip-consolidation

Axel Lin (2):
      ARM: exynos4: Fix build error due to 'gic_bank_offset' undeclared
      ARM: exynos4: Fix build error

 arch/arm/mach-exynos/cpu.c                 |    2 +-
 arch/arm/mach-exynos/mach-universal_c210.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
Jazz is not dead. It just smells funny...
