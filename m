From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Nov 2015 11:38:51 -0800
Subject: [PATCH 0/4] ARM: shmobile: Move SPI FLASH partition to subnode
Message-ID: <1448048335-23927-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As of commits 5cfdedb7b9a0fe38 ("mtd: ofpart: move ofpart partitions to a
dedicated dt node") and fe2585e9c29a650a ("doc: dt: mtd: support partitions
in a special 'partitions' subnode"), having partitions as direct subnodes
of an mtd device is discouraged. Hence move the SPI FLASH partition to a
"partitions" subnode.

Based on renesas-devel-20151120-v4.4-rc1

Geert Uytterhoeven (4):
  ARM: shmobile: bockw: Move SPI FLASH partition to subnode
  ARM: shmobile: lager: Move SPI FLASH partitions to subnode
  ARM: shmobile: porter: Move SPI FLASH partitions to subnode
  ARM: shmobile: silk: Move SPI FLASH partitions to subnode

 arch/arm/boot/dts/r8a7778-bockw.dts  | 13 ++++++++-----
 arch/arm/boot/dts/r8a7790-lager.dts  | 33 ++++++++++++++++++---------------
 arch/arm/boot/dts/r8a7791-porter.dts | 33 ++++++++++++++++++---------------
 arch/arm/boot/dts/r8a7794-silk.dts   | 33 ++++++++++++++++++---------------
 4 files changed, 62 insertions(+), 50 deletions(-)

-- 
2.1.4
