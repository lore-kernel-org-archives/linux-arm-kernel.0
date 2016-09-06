From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 6 Sep 2016 16:55:54 +0800
Subject: [PATCH 0/3] arm64: dts: berlin: fix dtc warnings
Message-ID: <20160906085557.4019-1-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a clean up series to fix berlin arm64 platforms dtc warnings by
add missing unit name of /soc node and /memory node.

Jisheng Zhang (3):
  arm64: dts: berlin4ct: add missing unit name to /soc node
  arm64: dts: berlin4ct-stb: add missing unit name to /memory node
  arm64: dts: berlin4ct-dmp: add missing unit name to /memory node

 arch/arm64/boot/dts/marvell/berlin4ct-dmp.dts | 2 +-
 arch/arm64/boot/dts/marvell/berlin4ct-stb.dts | 2 +-
 arch/arm64/boot/dts/marvell/berlin4ct.dtsi    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.9.3
