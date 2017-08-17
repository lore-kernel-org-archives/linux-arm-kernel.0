From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 17 Aug 2017 15:37:57 +0200
Subject: [GIT PULL] arm: mediatek: dts32 updates for v4.14
Message-ID: <9434dcb8-d38d-ff3a-a6ce-2b27d3a74cef@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof and Arnd,

for v4.14 please take the following pull request into account.

Thanks,
Matthias

---

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

   Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

   https://github.com/mbgg/linux-mediatek.git tags/v4.13-next-dts64

for you to fetch changes up to bdf2cbb2b3160122f7ff16445fdb73267fffd583:

   arm64: dts: Add Mediatek SoC MT2712 and evaluation board dts and Makefile 
(2017-08-17 15:33:45 +0200)

----------------------------------------------------------------
- add SoC mt7622 and its reference board
- cleanup of dts bindings
- mt6797: add watchdog and delete unused clock
- add support for SoC mt2701 and it's eval board

----------------------------------------------------------------
Matthias Brugger (4):
       ARM: mediatek: dts: Cleanup bindings documentation
       ARM: mediatek: dts: Add MT6797 binding
       arm64: dts: mediatek: add watchdog to MT6797
       arm64: dts: mediatek: Delete unused dummy clock for MT6797

Sean Wang (2):
       arm64: dts: mt7622: add basic nodes to the mt7622.dtsi file
       arm64: dts: mt7622: add dts file for MT7622 reference board variant 1

yt.shen at mediatek.com (2):
       dt-bindings: arm: Add bindings for Mediatek MT2712 SoC Platform
       arm64: dts: Add Mediatek SoC MT2712 and evaluation board dts and Makefile

  Documentation/devicetree/bindings/arm/mediatek.txt |   4 +
  .../interrupt-controller/mediatek,sysirq.txt       |   1 +
  .../devicetree/bindings/serial/mtk-uart.txt        |   1 +
  .../devicetree/bindings/watchdog/mtk-wdt.txt       |   6 +-
  arch/arm64/boot/dts/mediatek/Makefile              |   2 +
  arch/arm64/boot/dts/mediatek/mt2712-evb.dts        |  32 ++++
  arch/arm64/boot/dts/mediatek/mt2712e.dtsi          | 171 +++++++++++++++++++++
  arch/arm64/boot/dts/mediatek/mt6797.dtsi           |  12 +-
  arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts       |  27 ++++
  arch/arm64/boot/dts/mediatek/mt7622.dtsi           | 110 +++++++++++++
  10 files changed, 356 insertions(+), 10 deletions(-)
  create mode 100644 arch/arm64/boot/dts/mediatek/mt2712-evb.dts
  create mode 100644 arch/arm64/boot/dts/mediatek/mt2712e.dtsi
  create mode 100644 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
  create mode 100644 arch/arm64/boot/dts/mediatek/mt7622.dtsi
