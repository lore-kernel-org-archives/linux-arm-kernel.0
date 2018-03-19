From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 19 Mar 2018 11:20:22 +0100
Subject: [GIT PUL] ARM: mediatek: dts64 updates for v4.16-next
Message-ID: <e006b345-5711-3c1b-cd06-d75d87beefef@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

Please pull the following commits.

Thanks a lot,
Matthias

---

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/
tags/v4.16-next-dts64

for you to fetch changes up to 5f59955299a13196233bbc0fb72f8dd5b5ba22a1:

  arm64: dts: mt2712: Add auxadc device node. (2018-03-19 02:49:59 +0100)

----------------------------------------------------------------
- mt2712e add auxadc devcie

mt7622:
- fix clock bindings description
- add nodes for mmc, usb, SATA, PCI, ethernet, cpufreq, PMIC mt6380,
pinctrl, scpsys and clock devices

----------------------------------------------------------------
Chunfeng Yun (1):
      arm64: dts: mt7622: add usb device nodes

Ryder Lee (2):
      arm64: dts: mt7622: add PCIe device nodes
      arm64: dts: mt7622: add SATA device nodes

Sean Wang (11):
      arm64: dts: mt7622: add clock controller device nodes
      arm64: dts: mt7622: add power domain controller device nodes
      arm64: dts: mt7622: add pinctrl related device nodes
      arm64: dts: mt7622: add PMIC MT6380 related nodes
      arm64: dts: mt7622: add cpufreq related device nodes
      arm64: dts: mt7622: turn uart0 clock to real ones
      arm64: dts: mt7622: add SoC and peripheral related device nodes
      arm64: dts: mt7622: add flash related device nodes
      arm64: dts: mt7622: add ethernet device nodes
      arm64: dts: mt7622: add mmc related device nodes
      dt-bindings: clock: mediatek: add missing required #reset-cells

Zhiyong Tao (1):
      arm64: dts: mt2712: Add auxadc device node.

 .../bindings/arm/mediatek/mediatek,ethsys.txt      |   1 +
 .../bindings/arm/mediatek/mediatek,pciesys.txt     |   2 +
 .../bindings/arm/mediatek/mediatek,ssusbsys.txt    |   2 +
 arch/arm64/boot/dts/mediatek/mt2712-evb.dts        |   4 +
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi          |   9 +
 arch/arm64/boot/dts/mediatek/mt6380.dtsi           |  86 +++
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts       | 469 ++++++++++++++
 arch/arm64/boot/dts/mediatek/mt7622.dtsi           | 675 ++++++++++++++++++++-
 8 files changed, 1243 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6380.dtsi
