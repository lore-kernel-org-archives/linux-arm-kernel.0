From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  4 Aug 2013 11:33:58 +0200
Subject: [PATCH 0/6] ARM: sunxi: DTSI cleanups
Message-ID: <1375608844-13159-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This small patchset removes the useless reg property in the soc bus that is not
required for the simple-bus we're using.

It also fixes the base address of this bus in the node name that was wrong from
the start.

Maxime

Maxime Ripard (6):
  ARM: sun4i: a10: Remove useless simple-bus reg property
  ARM: sun4i: dt: Fix A10 SoC bus base address
  ARM: sun5i: a10s: Remove useless simple-bus reg property
  ARM: sun5i: dt: Fix A10s SoC bus base address
  ARM: sun5i: a13: Remove useless simple-bus reg property
  ARM: sun5i: dt: Fix A13 SoC bus base address

 arch/arm/boot/dts/sun4i-a10-cubieboard.dts       | 2 +-
 arch/arm/boot/dts/sun4i-a10-hackberry.dts        | 2 +-
 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts       | 2 +-
 arch/arm/boot/dts/sun4i-a10.dtsi                 | 3 +--
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts | 2 +-
 arch/arm/boot/dts/sun5i-a10s.dtsi                | 3 +--
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts        | 2 +-
 arch/arm/boot/dts/sun5i-a13.dtsi                 | 3 +--
 8 files changed, 8 insertions(+), 11 deletions(-)

-- 
1.8.3.4
