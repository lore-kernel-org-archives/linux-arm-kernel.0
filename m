From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Sat, 29 Sep 2018 17:20:22 +0200
Subject: [GIT PULL] ARM: arm64 dts updates for v4.20
Message-ID: <5b05e2ed-a909-dbb5-2b95-f1cab0ecc5c8@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,
Hi Olof,

Please take the following commit into accout for v4.20

Thanks a lot,
Matthias

---

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/
tags/v4.19-next-dts64

for you to fetch changes up to 3c2ac5b3ebcd387f5399c7888fae7279a65c606a:

  arm64: dts: Add spi slave dts (2018-09-28 23:05:26 +0200)

----------------------------------------------------------------
mt2712 - add spi slave node

mt7622:
- add timer node
- add CCI node
- add PMU node
- add bluetooth node
- add SPI slave node
- fix reference board (rfb1) memory and sort node alphabetically
- add support for Bananapi-R64

----------------------------------------------------------------
Leilk Liu (1):
      arm64: dts: Add spi slave dts

Ryder Lee (4):
      arm64: dts: mt7622: add timer, CCI-400 and PMU nodes
      arm64: dts: mt7622: add a bluetooth 5 device node
      arm64: dts: mt7622: fix ram size for rfb1
      arm64: dts: mt7622: add bananapi BPI-R64 board

 arch/arm64/boot/dts/mediatek/Makefile              |   1 +
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi          |  11 +
 .../boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts  | 530 +++++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts       | 196 ++++----
 arch/arm64/boot/dts/mediatek/mt7622.dtsi           |  62 +++
 5 files changed, 702 insertions(+), 98 deletions(-)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
