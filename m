From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  1 Dec 2016 15:25:50 +0100
Subject: [PATCH 0/4] ARM, arm64: dts: Use usb-phy fallback bindings
Message-ID: <1480602354-1446-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this short series makes use of fallback bindings for Renesas R-Car PHY
drivers in the DT of SoCs which already use those drivers.

Simon Horman (4):
  ARM: dts: r8a7790: Use renesas,rcar-gen2-usb-phy fallback binding
  ARM: dts: r8a7791: Use renesas,rcar-gen2-usb-phy fallback binding
  ARM: dts: r8a7794: Use renesas,rcar-gen2-usb-phy fallback binding
  arm64: dts: r8a7795: Use renesas,rcar-gen3-usb2-phy fallback binding

 arch/arm/boot/dts/r8a7790.dtsi           | 3 ++-
 arch/arm/boot/dts/r8a7791.dtsi           | 3 ++-
 arch/arm/boot/dts/r8a7794.dtsi           | 3 ++-
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 9 ++++++---
 4 files changed, 12 insertions(+), 6 deletions(-)

-- 
2.7.0.rc3.207.g0ac5344
