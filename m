From: will.deacon@arm.com (Will Deacon)
Date: Wed, 28 Sep 2011 11:38:16 +0100
Subject: [GIT PULL] DEBUG_LL platform updates for 3.2
Message-ID: <20110928103815.GA8344@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Please pull these DEBUG_LL platform updates for 3.2. You can find the core
updates (actually all resident in arch/arm/Kconfig.debug) in Russell's
for-next branch.

I think Stephen Boyd was planning to move MSM to the new code as well, but
I've not seen any code yet so I guess that can go in later.

Thanks!

Will


The following changes since commit 589593ec8b1790c0d9ea227a3811f819eff4f977:
  Stephen Boyd (1):
        ARM: 7097/1: debug: Move DEBUG_ICEDCC into the DEBUG_LL choice

are available in the git repository at:

  git://linux-arm.org/linux-2.6-wd.git for-arnd

Shawn Guo (1):
      arm/imx: use Kconfig choice for low-level debug UART selection

Will Deacon (2):
      ARM: plat-samsung: use Kconfig choice for debug UART selection
      ARM: realview: use Kconfig choice for debug UART selection

 arch/arm/Kconfig.debug                            |  117 ++++++++++++++++++--
 arch/arm/mach-mxs/include/mach/debug-macro.S      |   12 +--
 arch/arm/mach-realview/include/mach/debug-macro.S |   17 +---
 arch/arm/plat-mxc/include/mach/debug-macro.S      |   38 +------
 arch/arm/plat-samsung/Kconfig                     |    7 ++
 5 files changed, 122 insertions(+), 69 deletions(-)
