From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 12 Mar 2015 10:06:24 +0200
Subject: [RESEND 0/7] ARM: davinci: McASP related cleanups and fixes
Message-ID: <1426147591-31764-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

V1 was sent back in 10th of February [1], so resending it rebased on current
linux-next.

Clean up series of McASP device creation for da8xx and dm646x DMSoCs.

[1] https://lkml.org/lkml/2015/2/10/298

Regards,
Peter
---
Peter Ujfalusi (7):
  ARM: davinci: devices-da8xx: Add resource name for the McASP DMA
    request
  ARM: davinci: devices-da8xx: Add interrupt resource to McASP structs
  ARM: davinci: devices-da8xx: Clean up and correct the McASP device
    creation
  ARM: davinci: devices-da8xx: Add support for McASP2 on da830
  ARM: davinci: dm646x: Clean up the McASP DMA resources
  ARM: davinci: irqs: Correct McASP1 TX interrupt definition for DM646x
  ARM: davinci: dm646x: Add interrupt resource for McASPs

 arch/arm/mach-davinci/asp.h               |  7 +++
 arch/arm/mach-davinci/devices-da8xx.c     | 80 ++++++++++++++++++++++++++++---
 arch/arm/mach-davinci/dm646x.c            | 23 ++++++---
 arch/arm/mach-davinci/include/mach/irqs.h |  2 +-
 4 files changed, 98 insertions(+), 14 deletions(-)

-- 
2.3.0
