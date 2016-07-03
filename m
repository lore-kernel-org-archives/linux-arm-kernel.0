From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Sun, 3 Jul 2016 08:47:19 +0200
Subject: ARM: mediatek: dts 64 bit updates for v4.8
Message-ID: <8e60cf93-062d-368a-f2e0-58c747bb34ca@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Please merge the following updates for arm64 device tree branch.

Thanks,
Matthias

---

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

   Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

   https://github.com/mbgg/linux-mediatek.git tags/v4.7-next-dts

for you to fetch changes up to aea1c315b6395920bbeb69804e0355e57c67e086:

   arm64: dts: mediatek: add mt6755 support (2016-07-03 07:57:21 +0200)

----------------------------------------------------------------
- Add nodes for the DISP function ports
- Add dt-bindings for mt6755
- Add basic support for mt6755 SoC

----------------------------------------------------------------
CK Hu (1):
       arm64: dts: mt8173: Add display subsystem related nodes

Mars Cheng (2):
       Document: DT: Add bindings for mediatek MT6755 SoC Platform
       arm64: dts: mediatek: add mt6755 support

  Documentation/devicetree/bindings/arm/mediatek.txt |   4 +
  .../interrupt-controller/mediatek,sysirq.txt       |   1 +
  .../devicetree/bindings/serial/mtk-uart.txt        |   1 +
  arch/arm64/boot/dts/mediatek/Makefile              |   1 +
  arch/arm64/boot/dts/mediatek/mt6755-evb.dts        |  38 ++++
  arch/arm64/boot/dts/mediatek/mt6755.dtsi           | 145 ++++++++++++++
  arch/arm64/boot/dts/mediatek/mt8173.dtsi           | 223 
+++++++++++++++++++++
  7 files changed, 413 insertions(+)
  create mode 100644 arch/arm64/boot/dts/mediatek/mt6755-evb.dts
  create mode 100644 arch/arm64/boot/dts/mediatek/mt6755.dtsi
