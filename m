From: tony@atomide.com (Tony Lindgren)
Date: Mon, 8 Apr 2013 21:51:00 -0700
Subject: [GIT PULL 1/5] omap pm fixes for v3.10 merge window
Message-ID: <pull-1365483063-475562>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c309f7f46167e85d1aae2fd31f23e7d2b5cdfbe0:

  Merge branch 'for_3.10/omap_generic_cleanup_v2' of git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux into omap-for-v3.10/cleanup-v2 (2013-03-28 14:45:31 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.10/fixes-pm-signed

for you to fetch changes up to 5e7deed71290136cf70944e158f40401d0eed784:

  Merge tag 'omap-pm-v3.10/fixes/pm' of git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm into omap-for-v3.10/fixes-pm (2013-04-08 09:58:00 -0700)

----------------------------------------------------------------

Non-critical PM fix via Kevin Hilman <khilman@linaro.org>:

OMAP PM fixes for v3.10

Note that this has a dependency to omap-for-v3.10/cleanup-v2-signed.

----------------------------------------------------------------
Santosh Shilimkar (1):
      ARM: OMAP4+: PM: Restore CPU power state to ON with clockdomain force wakeup method

Tony Lindgren (1):
      Merge tag 'omap-pm-v3.10/fixes/pm' of git://git.kernel.org/.../khilman/linux-omap-pm into omap-for-v3.10/fixes-pm

 arch/arm/mach-omap2/cpuidle44xx.c |  1 +
 arch/arm/mach-omap2/omap-smp.c    | 12 ++++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)
