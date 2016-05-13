From: tony@atomide.com (Tony Lindgren)
Date: Fri, 13 May 2016 10:11:40 -0700
Subject: [GIT PULL 1/2] omap fixes for v4.7 merge window
Message-ID: <pull-1463159315-251654>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7472931f7f1e9d91f761dce30107ae345b61a5c3:

  ARM: dts: omap5: fix range of permitted wakeup pinmux registers (2016-04-26 10:16:12 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.7/fixes-v2

for you to fetch changes up to 65db875d110b8e517f81fa71c57a65fc6d0019ac:

  ARM: OMAP2+: AM43XX: Enable fixes for Cortex-A9 errata (2016-05-12 13:47:51 -0700)

----------------------------------------------------------------
Two fixes for omaps for v4.7 merge window, one to enable
ARM errata for am437x, and the other to add ARM errtum
workaround for dra7.

AFAIK these both can wait for v4.7, we can then request them
for stable kernels as needed.

----------------------------------------------------------------
Dave Gerlach (1):
      ARM: OMAP2+: AM43XX: Enable fixes for Cortex-A9 errata

Nishanth Menon (1):
      ARM: OMAP5 / DRA7: Introduce workaround for 801819

 arch/arm/mach-omap2/Kconfig       | 10 ++++++++
 arch/arm/mach-omap2/omap-secure.h |  1 +
 arch/arm/mach-omap2/omap-smp.c    | 48 +++++++++++++++++++++++++++++++++++----
 3 files changed, 54 insertions(+), 5 deletions(-)
