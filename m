From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 15 Mar 2016 09:26:32 +0900
Subject: [PATCH v2 0/2] ARM: dts: r8a7793: add CAN to device tree
Message-ID: <1458001594-632-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this short series adds CAN clocks and nodes to the r8a7794 device tree.

I am not aware of an r8a7794 board that exposes CAN - neither the alt nor
the silk board appear to - and thus am unsure of a way to test these
changes.  However, they are based on what is present for the r8a7791 SoC
and I am unable to find a difference in the SoC documentation.

This series is similar to a similar series I posted for the r8a7794
in January.

Based on renesas-devel-20160311-v4.5-rc7.

Changes in v2
* Correct clock node names
* Add MSTP9 clocks
* Omit clock-output-names property from new nodes

Simon Horman (2):
  ARM: dts: r8a7794: add CAN clocks to device tree
  ARM: dts: r8a7794: add CAN nodes to device tree

 arch/arm/boot/dts/r8a7794.dtsi            | 55 +++++++++++++++++++++++++++----
 include/dt-bindings/clock/r8a7794-clock.h |  3 ++
 2 files changed, 51 insertions(+), 7 deletions(-)

-- 
2.1.4
