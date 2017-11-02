From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 2 Nov 2017 19:52:56 +0100
Subject: [GIT PULL v2] Mediatek: 32-bit DTS updates for v4.15
Message-ID: <8a52a27e-f930-e873-6803-233dfa48b087@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

Please pull the following commits. This is version 2 of the pull request. I
dropped the PCI nodes addition as it needs more clarification.

Thanks
Matthias

---

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  https://github.com/mbgg/linux-mediatek.git tags/v4.14-next-dts32-2

for you to fetch changes up to eb54a522f164f89587381d665307d53acf75f114:

  arm: dts: mt7623: remove unused compatible string for pio node (2017-11-02
19:43:20 +0100)

----------------------------------------------------------------
- mt7623 update nodes to binding description
- mt2701 add display pwn nodes
- mt2701 update audio node description

----------------------------------------------------------------
Ryder Lee (4):
      arm: dts: mediatek: update audio node for mt2701 and mt7623
      arm: dts: mt7623: update crypto node
      arm: dts: mt7623: update usb related nodes
      arm: dts: mt7623: remove unused compatible string for pio node

Weiqing Kong (2):
      arm: dts: mt2701: add pwm backlight device node
      arm: dts: mt2701: enable display pwm backlight

 arch/arm/boot/dts/mt2701-evb.dts | 23 +++++++++++++++++++++++
 arch/arm/boot/dts/mt2701.dtsi    | 13 ++++++++++++-
 arch/arm/boot/dts/mt7623.dtsi    | 30 +++++++++++++++++-------------
 3 files changed, 52 insertions(+), 14 deletions(-)
