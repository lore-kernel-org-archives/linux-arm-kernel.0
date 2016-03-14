From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 14 Mar 2016 11:29:01 +0900
Subject: [PATCH 0/2] ARM: dts: r8a7793: add CAN to device tree
Message-ID: <1457922543-20975-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this short series adds CAN clocks and nodes to the r8a7794 device tree.

I am not aware of an r8a7794 board that exposes CAN - neither the alt nor
the silk board appear to - and thus am unsure of a way to test these
changes.  However, they are based on what is present for the r8a7791 SoC
and I am unable to find a difference in the SoC documentation.

This series is similar to a similar series I posted for the r8a7793
in January.

Based on renesas-devel-20160311-v4.5-rc7.

Simon Horman (2):
  ARM: dts: r8a7794: add CAN clocks to device tree
  ARM: dts: r8a7794: add CAN nodes to device tree

 arch/arm/boot/dts/r8a7794.dtsi            | 45 +++++++++++++++++++++++++++++--
 include/dt-bindings/clock/r8a7794-clock.h |  3 +++
 2 files changed, 46 insertions(+), 2 deletions(-)

-- 
2.1.4
