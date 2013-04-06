From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 05 Apr 2013 17:10:14 -0700
Subject: [GIT PULL] OMAP: PM: fixes for v3.10
Message-ID: <87hajkjz89.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

This OMAP PM fixes tag is based on your cleanup-v2 branch due to some
dependencies in the series from Santosh you already merged.

Kevin


The following changes since commit c309f7f46167e85d1aae2fd31f23e7d2b5cdfbe0:

  Merge branch 'for_3.10/omap_generic_cleanup_v2' of git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux into omap-for-v3.10/cleanup-v2 (2013-03-28 14:45:31 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git tags/omap-pm-v3.10/fixes/pm

for you to fetch changes up to b7806dc7cba840ea538706621486475d93a53c55:

  ARM: OMAP4+: PM: Restore CPU power state to ON with clockdomain force wakeup method (2013-04-05 14:19:25 -0700)

----------------------------------------------------------------
OMAP PM fixes for v3.10

----------------------------------------------------------------
Santosh Shilimkar (1):
      ARM: OMAP4+: PM: Restore CPU power state to ON with clockdomain force wakeup method

 arch/arm/mach-omap2/cpuidle44xx.c |  1 +
 arch/arm/mach-omap2/omap-smp.c    | 12 ++++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)
