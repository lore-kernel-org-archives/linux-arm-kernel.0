From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 17 Aug 2017 15:31:22 +0200
Subject: [GIT PULL] arm: mediatek: dts32 updates for v4.14
Message-ID: <c357cfa5-8464-8b94-caeb-4b48c2f42659@gmail.com>
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

   https://github.com/mbgg/linux-mediatek.git tags/v4.13-next-dts32

for you to fetch changes up to dfff569aaf8886dcc97b145a15f2213b4a4599e6:

   arm: dts: mt7623: cleanup binding file (2017-08-14 17:17:02 +0200)

----------------------------------------------------------------
- mt7623: add mt7623n and mt7623a plattform
- add mt7623 based reference boards
- mt7623: add usb3, ethernet, cpufreq,
- Add banana-pi board
- add mt6323 pmic
- mt2701: add larb-id property to smi larb

----------------------------------------------------------------
Chunfeng Yun (1):
       arm: dts: mt2701: Add usb3 device nodes

Honghui Zhang (1):
       arm: dts: mediatek: add larbid property for larb

John Crispin (4):
       arm: dts: mt7623: add mt6323.dtsi file
       arm: dts: mt7623: cleanup the mt7623n rfb uart nodes
       arm: dts: mt7623: enable the usb device on the mt7623n rfb
       arm: dts: mt7623: enable the nand device on the mt7623n nand rfb

Matthias Brugger (1):
       arm: dts: mt7623: fix mmc interrupt assignment

Ryder Lee (1):
       arm: dts: mt7623: cleanup binding file

Sean Wang (9):
       dt-bindings: net: mediatek: update documentation for reset signals
       arm: dts: mt7623: fixup binding violation missing reset in ethernet node
       dt-bindings: arm: mediatek: update for MT7623n SoC and relevant boards
       dt-bindings: arm: mediatek: add bindings for mediatek MT7623a SoC Platform
       arm: dts: mt7623: rename mt7623-evb.dts to arch/arm/boot/dts/mt7623n-rfb.dtsi
       arm: dts: mt7623: add support for Bananapi R2 (BPI-R2) board
       arm: dts: mt7623: add clock-frequency to CPU nodes
       arm: dts: mt2701: Add ethernet device node
       arm: dts: mt7623: Add SD-card and EMMC to bananapi-r2

  Documentation/devicetree/bindings/arm/mediatek.txt |  14 +-
  .../devicetree/bindings/net/mediatek-net.txt       |   6 +-
  arch/arm/boot/dts/Makefile                         |   3 +-
  arch/arm/boot/dts/mt2701.dtsi                      | 106 +++++
  arch/arm/boot/dts/mt6323.dtsi                      | 241 ++++++++++
  arch/arm/boot/dts/mt7623-evb.dts                   |  33 --
  arch/arm/boot/dts/mt7623.dtsi                      | 211 +++++++--
  arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts      | 487 +++++++++++++++++++++
  arch/arm/boot/dts/mt7623n-rfb-nand.dts             | 111 +++++
  arch/arm/boot/dts/mt7623n-rfb.dtsi                 |  92 ++++
  10 files changed, 1218 insertions(+), 86 deletions(-)
  create mode 100644 arch/arm/boot/dts/mt6323.dtsi
  delete mode 100644 arch/arm/boot/dts/mt7623-evb.dts
  create mode 100644 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
  create mode 100644 arch/arm/boot/dts/mt7623n-rfb-nand.dts
  create mode 100644 arch/arm/boot/dts/mt7623n-rfb.dtsi
