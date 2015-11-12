From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 12 Nov 2015 20:04:41 +0800
Subject: [PATCH 0/3] arm64: make some functions static
Message-ID: <1447329884-1644-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These functions are only called within the its own file, so they could
be declared static.

Jisheng Zhang (3):
  arm64: smp: make of_parse_and_init_cpus static
  arm64: mmu: make split_pud and fixup_executable static
  arm64: suspend: make hw_breakpoint_restore static

 arch/arm64/kernel/smp.c     | 2 +-
 arch/arm64/kernel/suspend.c | 2 +-
 arch/arm64/mm/mmu.c         | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.6.2
