From: fweisbec@gmail.com (Frederic Weisbecker)
Date: Wed,  2 Oct 2013 14:37:52 +0200
Subject: [GIT PULL] nohz: Full dynticks for 32 bits and arm support
Message-ID: <1380717475-11505-1-git-send-email-fweisbec@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ingo,

Please pull the timers/core branch that can be found at:

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	timers/core

Thanks,
	Frederic
---

Kevin Hilman (3):
      vtime: Add HAVE_VIRT_CPU_ACCOUNTING_GEN Kconfig
      nohz: Drop generic vtime obsolete dependency on CONFIG_64BIT
      ARM: Kconfig: allow full nohz CPU accounting


 arch/Kconfig        | 12 ++++++++++++
 arch/arm/Kconfig    |  1 +
 init/Kconfig        |  3 ++-
 kernel/time/Kconfig |  2 +-
 4 files changed, 16 insertions(+), 2 deletions(-)
