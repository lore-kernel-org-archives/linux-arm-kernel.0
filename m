From: tony@atomide.com (Tony Lindgren)
Date: Wed, 12 Jun 2013 11:24:34 -0700
Subject: [GIT PULL 3/6] omap pm changes for v3.11 merge window
In-Reply-To: <pull-1371061475-206272>
Message-ID: <mailman.0.1371061516.1060.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:

  Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.11/pm-signed

for you to fetch changes up to 49a34fd5380d249ae8a2173399c62fc5a1fddd70:

  Merge tag 'omap-pm-v3.10/cleanup/pm' of git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm into omap-for-v3.11/pm (2013-05-16 08:27:49 -0700)

----------------------------------------------------------------

Omap PM changes via Kevin Hilman <khilman@linaro.org>:

OMAP PM cleanups for v3.10

----------------------------------------------------------------
Santosh Shilimkar (4):
      ARM: OMAP4: PM: Avoid expensive cpu_suspend() path for all CPU power states except off
      ARM: OMAP4+: PM: Consolidate MPU subsystem PM code for re-use
      ARM: OMAP4+: Make secondary_startup function name more consistent
      ARM: OMAP4+: PM: Consolidate OMAP4 PM code to re-use it for OMAP5

Tony Lindgren (1):
      Merge tag 'omap-pm-v3.10/cleanup/pm' of git://git.kernel.org/.../khilman/linux-omap-pm into omap-for-v3.11/pm

 arch/arm/mach-omap2/common.h              |  4 +-
 arch/arm/mach-omap2/omap-headsmp.S        |  8 ++--
 arch/arm/mach-omap2/omap-mpuss-lowpower.c | 69 +++++++++++++++++++++++++------
 arch/arm/mach-omap2/omap-smp.c            |  6 +--
 arch/arm/mach-omap2/pm44xx.c              | 58 +++++++++++++++++++++-----
 5 files changed, 113 insertions(+), 32 deletions(-)
