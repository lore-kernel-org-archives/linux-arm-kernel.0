From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 21 Jan 2016 14:09:39 +0900
Subject: [PATCH 0/2] ARM: dts: r8a7793: add CAN to device tree
Message-ID: <1453352981-16104-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this short series adds CAN clocks and nodes to the r8a7793 device tree.

I am not aware of an r8a7793 board that exposes CAN - the gose
board does not appear to - and thus am unsure of a way to test these changes.
However, they are based on what is present for the r8a7791 SoC and
I am unable to find a difference in the SoC documentation.

As far as I can tell the r8a7794 is in a similar situation and
I plan to post a follow-up series for that SoC depending on feedback
for this series.

Simon Horman (2):
  ARM: dts: r8a7793: add CAN clocks
  ARM: dts: r8a7793: add CAN nodes to device tree

 arch/arm/boot/dts/r8a7793.dtsi | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

-- 
2.1.4
