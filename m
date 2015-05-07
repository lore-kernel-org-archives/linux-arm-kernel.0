From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu,  7 May 2015 15:45:01 +0100
Subject: [PATCH 0/4] ARM/ARM64: vexpress: fixes for v4.1
Message-ID: <1431009905-29265-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd/Olof,

Here are few fixes posted on the list and are scattered around.
So I am sending them as a series so that you can pick them up easily.
Let me know if you prefer a pull request.

Regards,
Sudeep

Robert Schwebel (2):
  ARM: vexpress/ca9: Add unified-cache property to l2 cache node
  ARM: vexpress/ca9: Add interrupt-affinity to the PMU node

Sudeep Holla (2):
  ARM64: juno: add sp810 support and fix sp804 clock frequency
  ARM: vexpress/tc2: Add interrupt-affinity to the PMU node

 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts    |  1 +
 arch/arm/boot/dts/vexpress-v2p-ca9.dts        | 11 ++++++----
 arch/arm64/boot/dts/arm/juno-motherboard.dtsi | 31 +++++++++++++++++++++++----
 3 files changed, 35 insertions(+), 8 deletions(-)

-- 
1.9.1
