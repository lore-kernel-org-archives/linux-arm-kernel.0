From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 25 Jan 2017 14:46:56 +0100
Subject: [GIT PULL] arm: mediatek: dts changes for v4.11
Message-ID: <82e017a8-ade7-b16f-740c-6c106f2f8049@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, hi Olof,

Please merge the following changes for 32-bit dts files.

Thanks,
Matthias

---

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

   Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

   https://github.com/mbgg/linux-mediatek.git tags/v4.10-next-dts32

for you to fetch changes up to e348dc74f798c2df31c685bf0c814396f4f3b735:

   arm: dts: mt2701: Add thermal device node. (2017-01-24 11:24:35 +0100)

----------------------------------------------------------------
Lots of updates for mt2701:
Rearrange the dt nodes and fix unit address for pincontroler
Add nodes for:
- clock controller subsystems
- scpsys controller
- iommu and smi
- spi
- nand
- auxadc
- thermal controller and zones

Email address updated for mt7623 devicetree files.

----------------------------------------------------------------
Dawei Chien (1):
       arm: dts: mt2701: Add thermal device node.

Honghui Zhang (1):
       ARM: dts: mt2701: add iommu/smi dtsi node for mt2701

James Liao (3):
       arm: dts: mt2701: Sort DT nodes by register address
       arm: dts: mt2701: Add subsystem clock controller device nodes
       arm: dts: mt2701: Add power domain controller device node

John Crispin (1):
       ARM: dts: mediatek: update my email address

Leilk Liu (1):
       arm: dts: mt2701: Add spi device node

Xiaolei Li (1):
       arm: dts: mt2701: Add nand device node

Zhiyong Tao (1):
       arm: dts: mt2701: Add auxadc device node.

  arch/arm/boot/dts/mt2701-evb.dts |  54 +++++++++
  arch/arm/boot/dts/mt2701.dtsi    | 247 
++++++++++++++++++++++++++++++++++++---
  arch/arm/boot/dts/mt7623-evb.dts |   2 +-
  arch/arm/boot/dts/mt7623.dtsi    |   2 +-
  4 files changed, 285 insertions(+), 20 deletions(-)
