From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 13 Jun 2014 15:43:18 +0200
Subject: [PATCH 0/3] ARM: at91/dt: clock fixes
Message-ID: <1402667001-11207-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some clocks were not properly defined:
 - ICPLL and OUT values for PLLA got mixed on sam9x5 and sam9n12
 - mainck was not correctly defined on sam9261

Alexandre Belloni (3):
  ARM: at91/dt: sam9x5: correct PLLA ICPLL and OUT values
  ARM: at91/dt: sam9n12: correct PLLA ICPLL and OUT values
  ARM: at91/dt: sam9261: correctly define mainck

 arch/arm/boot/dts/at91sam9261.dtsi | 10 ++++++++--
 arch/arm/boot/dts/at91sam9n12.dtsi |  4 ++--
 arch/arm/boot/dts/at91sam9x5.dtsi  |  4 ++--
 3 files changed, 12 insertions(+), 6 deletions(-)

-- 
1.9.1
