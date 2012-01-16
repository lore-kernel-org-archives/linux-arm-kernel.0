From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 16 Jan 2012 12:05:35 +0000
Subject: [PATCH 0/2] Convert remaining platforms to common sched_clock()
Message-ID: <1326715537-14968-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Only two platforms are left with their own sched_clock() implementation.
This patch series converts them, leading in both cases to some cleanup.

Compile tested only.

Marc Zyngier (2):
  ARM: davinci: convert to common sched_clock() implementation
  ARM: prima2: convert to common sched_clock() implementation

 arch/arm/Kconfig             |    2 ++
 arch/arm/mach-davinci/time.c |   24 +++++++-----------------
 arch/arm/mach-prima2/timer.c |   21 +++++++--------------
 3 files changed, 16 insertions(+), 31 deletions(-)

-- 
1.7.7.1
