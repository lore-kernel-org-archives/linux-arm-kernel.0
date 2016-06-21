From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 21 Jun 2016 11:11:23 +0200
Subject: [GIT PULL] ARM: mvebu: cleanup for v4.8 (#1)
Message-ID: <87vb129a9w.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for cleanup for mvebu for v4.8.

Gregory

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-cleanup-4.8-1

for you to fetch changes up to d705c1a66e151e587271265c29844817d5108375:

  ARM: Kirkwood: fix kirkwood_pm_init() declaration/type (2016-06-16 12:01:37 +0200)

----------------------------------------------------------------
mvebu cleanup for 4.8 (part 1)

Various warning fixes

----------------------------------------------------------------
Ben Dooks (8):
      mvebu: fix missing includes in pmsu.c
      mvebu: fix missing include of common.h in pm.c
      mvebu: fix missing include of common.h in cpu-reset.c
      mvebu: make mvebu_armada375_smp_wa_init() static
      mvebu: add definition for coherency_base
      ARM: orion5x: make orion5x_legacy_handle_irq static
      ARM: Kirkwood: make kirkwood_disable_mbus_error_propagation() static
      ARM: Kirkwood: fix kirkwood_pm_init() declaration/type

 arch/arm/mach-mvebu/coherency.h         | 1 +
 arch/arm/mach-mvebu/cpu-reset.c         | 2 ++
 arch/arm/mach-mvebu/kirkwood-pm.c       | 4 ++--
 arch/arm/mach-mvebu/kirkwood.c          | 2 +-
 arch/arm/mach-mvebu/pm.c                | 1 +
 arch/arm/mach-mvebu/pmsu.c              | 3 ++-
 arch/arm/mach-mvebu/system-controller.c | 2 +-
 arch/arm/mach-orion5x/irq.c             | 2 +-
 8 files changed, 11 insertions(+), 6 deletions(-)
