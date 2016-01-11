From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 11 Jan 2016 13:32:51 +0900
Subject: [GIT PULL] Renesas ARM Based SoC DT Fixes for v4.5
Message-ID: <cover.1452486598.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC DT fixes for v4.5.

This pull request is based on the
"Third Round of Renesas ARM Based SoC DT Updates for v4.5",
tagged as renesas-dt3-for-v4.5, which you have already pulled.

This adds the required property to partitions nodes for the device trees
of Renesas ARM Based SoC which have such a node added in patches queued up
for v4.5.

The following changes since commit d01c8bec91414f2110370dfcb9dd33fc0e573cee:

  ARM: shmobile: r8a779x: use SoC-specific usb-dmac compatibility strings (2015-12-17 10:10:54 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-fixes-for-v4.5

for you to fetch changes up to 8bc403b78ffb774d8dc944abb0826c46c0dca09d:

  ARM: dts: silk: Add compatible property to "partitions" node (2016-01-07 08:39:06 +1100)

----------------------------------------------------------------
Renesas ARM Based SoC DT Fixes for v4.5

* Add compatible property to "partitions" node

  As of commit e488ca9f8d4f62c2 ("doc: dt: mtd: partitions: add compatible
  property to "partitions" node"), which is in v4.4-rc6, the "partitions"
  subnode of an SPI FLASH device node must have a compatible property. The
  partitions are no longer detected if it is not present.

----------------------------------------------------------------
Geert Uytterhoeven (6):
      ARM: dts: bockw: Add compatible property to "partitions" node
      ARM: dts: lager: Add compatible property to "partitions" node
      ARM: dts: koelsch: Add compatible property to "partitions" node
      ARM: dts: porter: Add compatible property to "partitions" node
      ARM: dts: gose: Add compatible property to "partitions" node
      ARM: dts: silk: Add compatible property to "partitions" node

 arch/arm/boot/dts/r8a7778-bockw.dts   | 1 +
 arch/arm/boot/dts/r8a7790-lager.dts   | 1 +
 arch/arm/boot/dts/r8a7791-koelsch.dts | 1 +
 arch/arm/boot/dts/r8a7791-porter.dts  | 1 +
 arch/arm/boot/dts/r8a7793-gose.dts    | 1 +
 arch/arm/boot/dts/r8a7794-silk.dts    | 1 +
 6 files changed, 6 insertions(+)
