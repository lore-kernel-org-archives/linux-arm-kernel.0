From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Sun, 22 Jul 2018 22:47:46 +0200
Subject: [GIT PULL] dts32 commits for v4.19
Message-ID: <2d918d15-d1d3-b4e0-7427-0b3baa56100a@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,
Hi Arnd,

Please take into account the following patches.
Thanks a lot,
Matthias

---

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/
v4.18-next/dts32

for you to fetch changes up to 11a20c5601c5f0c685fa3a166348b7ffa830e123:

  dt-bindings: arm: mediatek: cleanup MT7623N reference boards (2018-07-16
15:57:40 +0200)

----------------------------------------------------------------
Frank Wunderlich (1):
      arm: dts: mediatek: Fix pio-leds for Bananapi-R2

Ryder Lee (2):
      arm: dts: mt7623: cleanup MT7623N NAND dts file
      dt-bindings: arm: mediatek: cleanup MT7623N reference boards

Viresh Kumar (1):
      arm: dts: mediatek: Add missing cooling device properties for CPUs

 Documentation/devicetree/bindings/arm/mediatek.txt |  3 -
 arch/arm/boot/dts/Makefile                         |  1 -
 arch/arm/boot/dts/mt7623.dtsi                      |  3 +
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts      |  6 +-
 arch/arm/boot/dts/mt7623n-rfb-nand.dts             | 73 ------------------
 arch/arm/boot/dts/mt7623n-rfb.dtsi                 | 86 ----------------------
 6 files changed, 6 insertions(+), 166 deletions(-)
 delete mode 100644 arch/arm/boot/dts/mt7623n-rfb-nand.dts
 delete mode 100644 arch/arm/boot/dts/mt7623n-rfb.dtsi
