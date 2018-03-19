From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 19 Mar 2018 11:18:19 +0100
Subject: [GIT PULL] ARM: mediatek: dts32 updates for v4.16-next
Message-ID: <c1fa5369-4aef-1e51-80cd-ef4d2fb136c6@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof and Arnd,

Please take the below commits into consideration.

Thanks a lot,
Matthias

---

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/
tags/v4.16-next-dts32

for you to fetch changes up to c10a98c4f66bb5d727a6525fd3bb80b4005df123:

  arm: dts: mt7623: add PCIe related nodes (2018-03-19 02:39:48 +0100)

----------------------------------------------------------------
mt7623:
- fix style issues of the dts
- add cpu clock properties
- add PCI controller
- add mt7623 reference board

banapi-r2:
- enable missing uarts
- fix regulator for mmc
- fix USB initialization

----------------------------------------------------------------
Ryder Lee (1):
      arm: dts: mt7623: add PCIe related nodes

Sean Wang (7):
      dt-bindings: arm: mediatek: add support for more mt7623 reference boards
      arm: dts: mt7623: fix USB initialization fails on bananapi-r2
      arm: dts: mt7623: fix the regulators mmc should use on bananapi-r2
      arm: dts: mt7623: enable three available UARTs on bananapi-r2
      arm: dts: mt7623: add related clock properties to cpu[1-3] nodes
      arm: dts: mt7623: remove useless property pinctrl-names at node switch at 0
      arm: dts: mt7623: use - instead of _ in DT node name

 Documentation/devicetree/bindings/arm/mediatek.txt |   9 ++
 arch/arm/boot/dts/mt7623.dtsi                      | 126 ++++++++++++++++++-
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts      | 133 ++++++++++++++++-----
 arch/arm/boot/dts/mt7623n-rfb-nand.dts             |   6 +-
 4 files changed, 232 insertions(+), 42 deletions(-)
