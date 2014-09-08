From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  8 Sep 2014 09:27:43 +0900
Subject: [PATCH 0/5] ARM: shmobile: Use SoC-specific clock source compat
 strings
Message-ID: <1410136068-32220-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In general Renesas hardware is not documented to the extent
where the relationship between IP blocks on different SoCs can be assumed
although they may appear to operate the same way. Furthermore the
documentation typically does not specify a version for individual
IP blocks. For these reasons a convention of using the SoC name in place
of a version and providing SoC-specific compat strings has been adopted.

Although not universally liked this convention is used in the bindings
for a number of drivers for Renesas hardware. The purpose of this series
is to make use of SoC specific clock source strings.

Simon Horman (5):
  ARM: shmobile: r8a7740: Use SoC-specific 48-bit CMT compat string
  ARM: shmobile: r8a7790: Use SoC-specific 48-bit CMT compat string
  ARM: shmobile: r8a7791: Use SoC-specific 48-bit CMT compat string
  ARM: shmobile: r7s72100: Use SoC-specific MTU2 compat string
  ARM: shmobile: r8a7779: Use SoC-specific TMU compat string

 arch/arm/boot/dts/r7s72100.dtsi | 2 +-
 arch/arm/boot/dts/r8a7740.dtsi  | 2 +-
 arch/arm/boot/dts/r8a7779.dtsi  | 6 +++---
 arch/arm/boot/dts/r8a7790.dtsi  | 4 ++--
 arch/arm/boot/dts/r8a7791.dtsi  | 4 ++--
 5 files changed, 9 insertions(+), 9 deletions(-)

-- 
2.0.1
