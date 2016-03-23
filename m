From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed, 23 Mar 2016 23:24:17 +0100
Subject: [PATCH 0/4] ARM64: mvebu: Armada 3700/7K/8K DT cleanups
Message-ID: <1458771861-12392-1-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series cleans up some minor DT nits spotted in next-20160323.

It's structured so that non-functional changes come before functional changes
for each SoC family.

Regards,
Andreas

Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: devicetree at vger.kernel.org

Andreas F?rber (4):
  arm64: dts: marvell: Clean up armada-3720-db
  arm64: dts: marvell: Rename armada-37xx USB node
  arm64: dts: marvell: Clean up armada-7040-db
  arm64: dts: marvell: Rename armada-ap806 XOR nodes

 arch/arm64/boot/dts/marvell/armada-3720-db.dts     | 35 +++++++--------
 arch/arm64/boot/dts/marvell/armada-372x.dtsi       |  1 -
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi       |  4 +-
 arch/arm64/boot/dts/marvell/armada-7040-db.dts     | 52 ++++++++++------------
 arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi |  1 -
 arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi |  2 -
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      | 15 +++----
 7 files changed, 47 insertions(+), 63 deletions(-)

-- 
2.6.2
