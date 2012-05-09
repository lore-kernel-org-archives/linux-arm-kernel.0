From: tony@atomide.com (Tony Lindgren)
Date: Wed, 9 May 2012 08:35:36 -0700
Subject: [GIT PULL] omap fixes for v3.4-rc6, take2
Message-ID: <20120509153535.GJ5088@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

Here's this one updated to drop the non-regression patch and to use updated
version of Enrico's patch. The other two patches are the same.

Regards,

Tony


The following changes since commit 69964ea4c7b68c9399f7977aa5b9aa6539a6a98a:

  Linux 3.4-rc5 (2012-04-29 15:19:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-fixes-for-v3.4-rc6-take-2

for you to fetch changes up to 1a21932edc10de0dfd843797427719e5da43355b:

  ARM: OMAP: igep0020: fix smsc911x dummy regulator id (2012-05-09 08:12:05 -0700)

----------------------------------------------------------------
Fix two board spefific regressions and one regression caused by bad documentation

----------------------------------------------------------------
Archit Taneja (1):
      ARM: OMAP: Revert "ARM: OMAP: ctrl: Fix CONTROL_DSIPHY register fields"

Enrico Butera (1):
      ARM: OMAP: igep0020: fix smsc911x dummy regulator id

Janusz Krzysztofik (1):
      ARM: OMAP1: Amstrad Delta: Fix wrong IRQ base in FIQ handler

 arch/arm/mach-omap1/ams-delta-fiq.c                |    2 +-
 arch/arm/mach-omap2/board-igep0020.c               |    2 +-
 .../include/mach/ctrl_module_pad_core_44xx.h       |    8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)
