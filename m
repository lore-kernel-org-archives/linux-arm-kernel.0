From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 20 Apr 2017 12:05:43 -0700
Subject: [PATCH 0/2] arm64: perf: Add L2 cache events for ARMv8 PMuv3 and A53
Message-ID: <20170420190546.7453-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

While investigating why there were no L2 cache events generated for a Cortex
A53-like PMU, it turned out that none of the L2 cache events were mapped.

This is also the case for ARMv8 PMUv3, which seems a little odd considering
they are defined.

Thanks!

Florian Fainelli (2):
  arm64: perf: Wire-up Cortex A53 L2 cache events and DTLB refills
  arm64: pmu: Wire-up L2 cache events for ARMv8 PMUv3

 arch/arm64/kernel/perf_event.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

-- 
2.9.3
