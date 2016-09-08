From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu,  8 Sep 2016 11:25:59 -0400
Subject: [PATCH 0/2] ARM: dts: s5p: Remove skeleton.dtsi usage and fix memory
 node DTC warnings
Message-ID: <1473348361-15784-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This small patch series is similar to [0] that removed the skeleton.dtsi
usage for Exynos DTS. This series do the same for S5PV210 boards DTS.

[0]: http://www.spinics.net/lists/kernel/msg2333268.html

Best regards,
Javier


Javier Martinez Canillas (2):
  ARM: dts: s5p: Remove skeleton.dtsi inclusion for S5PV210
  ARM: dts: s5p: Add missing unit name to memory nodes for S5PV210
    boards

 arch/arm/boot/dts/s5pv210-aquila.dts   | 2 +-
 arch/arm/boot/dts/s5pv210-goni.dts     | 2 +-
 arch/arm/boot/dts/s5pv210-smdkc110.dts | 2 +-
 arch/arm/boot/dts/s5pv210-smdkv210.dts | 2 +-
 arch/arm/boot/dts/s5pv210-torbreck.dts | 2 +-
 arch/arm/boot/dts/s5pv210.dtsi         | 4 +++-
 6 files changed, 8 insertions(+), 6 deletions(-)

-- 
2.7.4
