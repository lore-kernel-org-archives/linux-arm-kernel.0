From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 21 Dec 2017 12:45:24 +0100
Subject: [GIT PULL v2] arm: Updates of armv7 DTS for v4.15-next
Message-ID: <938d913c-02c2-e44c-1c03-e620276ce35e@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, hi Arnd,

Please have a look on the following patches.

Thanks a lot,
Matthias

---
The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git
tags/v4.15-next-dts32

for you to fetch changes up to a227cf4dfd74a873857c9cc017100168d01539ed:

  dt-bindings: ARM: Mediatek: Fix ethsys documentation (2017-12-20 18:10:12 +0100)

----------------------------------------------------------------
- add reset cells mt2701 and mt7623 ethsys
- update mmc nodes for mt7623
- mt7623 change mmc card detection pin to active low
- mt7623 set unit address to lower case

----------------------------------------------------------------
Mathieu Malaterre (1):
      arm: mt7: dts: Remove leading 0x and 0s from bindings notation

Matthias Brugger (3):
      arm: dts: mt7623: Update ethsys binding
      arm: dts: mt2701: Add reset-cells
      dt-bindings: ARM: Mediatek: Fix ethsys documentation

Sean Wang (2):
      arm: dts: mt7623: update mmc related nodes with the appropriate fallback
      arm: dts: mt7623: fix card detection issue on bananapi-r2

 Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt | 1 +
 arch/arm/boot/dts/mt2701.dtsi                                      | 2 ++
 arch/arm/boot/dts/mt7623.dtsi                                      | 5 +++--
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts                      | 2 +-
 arch/arm/boot/dts/mt7623n-rfb-nand.dts                             | 2 +-
 5 files changed, 8 insertions(+), 4 deletions(-)
