From: chris.paterson2@renesas.com (Chris Paterson)
Date: Wed, 23 Nov 2016 12:14:03 +0000
Subject: [PATCH 0/3] arm64: dts: r8a7796: Add CAN/CAN FD support
Message-ID: <1479903243-1860-1-git-send-email-chris.paterson2@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds CAN and CAN FD support to the r8a7796.

Based on renesas-devel-20161122-v4.9-rc6.

Chris Paterson (3):
  arm64: dts: r8a7796: Add CAN external clock support
  arm64: dts: r8a7796: Add CAN support
  arm64: dts: r8a7796: Add CAN FD support

 .../devicetree/bindings/net/can/rcar_can.txt       | 12 +++--
 .../devicetree/bindings/net/can/rcar_canfd.txt     | 12 +++--
 arch/arm64/boot/dts/renesas/r8a7796.dtsi           | 61 ++++++++++++++++++++++
 3 files changed, 75 insertions(+), 10 deletions(-)

-- 
1.9.1
