From: will.deacon@arm.com (Will Deacon)
Date: Wed,  3 Nov 2010 17:22:24 +0000
Subject: [PATCH 0/3] Some not-very-exciting random one-liners
Message-ID: <1288804947-21213-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I've had these guys lying around in my tree so I thought I'd share.
Perhaps the only interesting observation is that nobody has complained
about the issue addressed in patch 3, implying that very few people are
still using OABI with v7 cores.

All patches taken against 2.6.37-rc1.

Will Deacon (3):
  ARM: backtrace: fix calculation of thread stack base
  ARM: perf-events: squash compiler warning
  ARM: atomic64: use generic implementation for OABI configurations

 arch/arm/Kconfig             |    2 +-
 arch/arm/kernel/perf_event.c |    2 +-
 arch/arm/kernel/stacktrace.c |    2 +-
 arch/arm/kernel/unwind.c     |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)
