From: tony@atomide.com (Tony Lindgren)
Date: Wed, 29 Feb 2012 12:15:06 -0800
Subject: [GIT PULL 2/5] First set of omap SoC related changes
In-Reply-To: <pull-1330546506-268554>
Message-ID: <mailman.0.1330546513.14256.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This contains two changes that were too late
for the previous merge window so let's get these
out of the way first.

Regards,

Tony


The following changes since commit dcd6c92267155e70a94b3927bce681ce74b80d1f:
  Linus Torvalds (1):
        Linux 3.3-rc1

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap soc

Tony Lindgren (1):
      Merge branch 'soc-part2' into soc

Vaibhav Hiremath (2):
      ARM: OMAP2+: Make cpu_rev static global variable
      ARM: OMAP2+: split omap2/3/4_check_revision function

 arch/arm/mach-omap2/id.c              |  186 ++++++++++++++-------------------
 arch/arm/mach-omap2/io.c              |    9 ++-
 arch/arm/plat-omap/include/plat/cpu.h |    7 +-
 3 files changed, 92 insertions(+), 110 deletions(-)
