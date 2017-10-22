From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 23 Oct 2017 00:06:22 +0200
Subject: [GIT PULL] Mediatek: 32-bit DT update for v4.15
Message-ID: <c7145c00-b2b9-780c-0bfd-15f7d8a08dd6@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

Please pull the following commits.

Thanks
Matthias

---
The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  https://github.com/mbgg/linux-mediatek.git tags/v4.14-next-dts32

for you to fetch changes up to 355d73e3b2e20d42195268e539a299dedbcc4f59:

  arm: dts: mt7623: remove unused compatible string for pio node (2017-10-20
13:15:59 +0200)

----------------------------------------------------------------
- mt76233 add PCIe node
- mt7623 update nodes to binding description
- mt2701 add display pwn nodes
- mt2701 update audio node description

----------------------------------------------------------------
Ryder Lee (5):
      arm: dts: mediatek: update audio node for mt2701 and mt7623
      arm: dts: mt7623: add PCIe related nodes
      arm: dts: mt7623: update crypto node
      arm: dts: mt7623: update usb related nodes
      arm: dts: mt7623: remove unused compatible string for pio node

Weiqing Kong (2):
      arm: dts: mt2701: add pwm backlight device node
      arm: dts: mt2701: enable display pwm backlight

 arch/arm/boot/dts/mt2701-evb.dts              |  23 +++++
 arch/arm/boot/dts/mt2701.dtsi                 |  13 ++-
 arch/arm/boot/dts/mt7623.dtsi                 | 138 +++++++++++++++++++++++---
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts |  30 ++++++
 4 files changed, 190 insertions(+), 14 deletions(-)
