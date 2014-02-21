From: will.deacon@arm.com (Will Deacon)
Date: Fri, 21 Feb 2014 16:54:30 +0000
Subject: [PATCH 0/3] ARM: perf: updates for 3.15
Message-ID: <1393001673-8589-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Here is a handful of ARM perf patches that I plan to push for 3.15 that
I don't think have previously been on the list. I've also got Stephen
Boyd's series adding support for Krait, but they've already been reviewed
here.

Cheers,

Will

--->8

Albin Tonnerre (1):
  ARM: perf: add support for the Cortex-A12 PMU

Mark Rutland (1):
  ARM: perf: remove unused PMU probing code

Will Deacon (1):
  ARM: perf: hook up perf_sample_event_took around pmu irq handling

 Documentation/devicetree/bindings/arm/pmu.txt |   1 +
 arch/arm/kernel/perf_event.c                  |  11 +-
 arch/arm/kernel/perf_event_cpu.c              |  10 +-
 arch/arm/kernel/perf_event_v7.c               | 158 ++++++++++++++++++++++++++
 4 files changed, 169 insertions(+), 11 deletions(-)

-- 
1.8.2.2
