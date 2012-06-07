From: jon-hunter@ti.com (Jon Hunter)
Date: Thu, 7 Jun 2012 17:11:04 -0500
Subject: [PATCH V2 0/2] arm/dts: Add OMAP2420 SDP support
Message-ID: <1339107066-10461-1-git-send-email-jon-hunter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series fixes the OMAP2 interrupt controller binding and adds support for
the OMAP2420 SDP board. I have verified that the kernel boots with device-tree
on this board.

This series is based upon the linux-omap master branch (3.5-rc1).

Jon Hunter (2):
  arm/dts: OMAP2: Add support for OMAP2420 SDP
  arm/dts: OMAP2: Fix interrupt controller binding

 arch/arm/boot/dts/omap2.dtsi       |    2 ++
 arch/arm/boot/dts/omap2420-sdp.dts |   20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap2420-sdp.dts

-- 
1.7.9.5
