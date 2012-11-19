From: robherring2@gmail.com (Rob Herring)
Date: Mon, 19 Nov 2012 08:42:39 -0600
Subject: [GIT PULL] Highbank DEBUG_LL clean-up
Message-ID: <50AA455F.2040909@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Please pull DEBUG_LL clean-up for highbank. This is based on a merge of
calxeda/ecx-2000 and devel/debug_ll_init arm-soc branches. It was more
that just a trivial merge conflict. One hunk is dependent on
calxeda/ecx-2000 changes.

Rob

The following changes since commit d3ad4a60a1b1448e59914eebefe1ccc8e64f9e2f:

  Merge remote-tracking branch 'arm-soc/devel/debug_ll_init' into debug_ll (2012-11-07 17:59:14 -0600)

are available in the git repository at:


  git://sources.calxeda.com/kernel/linux.git tags/highbank-debugll-cleanup

for you to fetch changes up to 52530343331dc111e0899bfc976f21ace5b5c95c:

  ARM: highbank: use common debug_ll_io_init (2012-11-07 18:00:24 -0600)

----------------------------------------------------------------
Use common debug_ll_init function and remove the static mapping code
from mach-highbank.

----------------------------------------------------------------
Rob Herring (1):
      ARM: highbank: use common debug_ll_io_init

 arch/arm/mach-highbank/Makefile   |    1 -
 arch/arm/mach-highbank/core.h     |    5 -----
 arch/arm/mach-highbank/highbank.c |    8 ++------
 arch/arm/mach-highbank/lluart.c   |   34 ----------------------------------
 4 files changed, 2 insertions(+), 46 deletions(-)
 delete mode 100644 arch/arm/mach-highbank/lluart.c
