From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 5 Aug 2015 15:15:08 +0800
Subject: [GIT PULL] CSR SiRFSoC DT for 4.3
Message-ID: <CAGsJ_4yxiytb3bUVsG5jTWKQdY7xE8HKBz7Og_Se=mB_cr3ZEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

The following changes since commit bc0195aad0daa2ad5b0d76cce22b167bc3435590:

  Linux 4.2-rc2 (2015-07-12 15:10:30 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/baohua/linux.git
tags/sirf-dts-for-4.3

for you to fetch changes up to 2cd212427fa9cbf19c1f353d6e14b959e8f112f7:

  ARM: dts: atlas7: add a GPIO key for rearview button (2015-08-05
22:44:21 +0800)

----------------------------------------------------------------
ARM: sirf: dts update for 4.3

some missed dt nodes or props for sirf dts for 4.3.
Among them:
- G2D
- PWM
- JPEG
- Multimedia
- PMU(performance monitor unit)
- GMAC
- SDR(software digital radio) and its DMA
- pinmux for NAND
- GPIO key

----------------------------------------------------------------
Andy Sun (1):
      ARM: dts: atlas7: add a GPIO key for rearview button

Dongli Li (1):
      ARM: dts: atlas7: add lost G2D node

Guo Zeng (1):
      ARM: dts: atlas7: add lost PWM node

Huayi Li (1):
      ARM: dts: atlas7: put pinctl property to get pinmux for NAND

Lily.Li (1):
      ARM: dts: atlas7: add lost jpeg node

Qipan Li (1):
      ARM: dts: atlas7: add alias name for spi device

Xiaofeng Fei (1):
      ARM: dts: atlas7: add multimedia codec node

Ye He (2):
      ARM: dts: atlas7: add performance monitor unit node
      ARM: dts: atlas7: add lost gmac node

Yonghui Zhang (1):
      ARM: dts: atlas7: add software digital radio nodes and its DMA channels

 arch/arm/boot/dts/atlas7-evb.dts |   18 +++++++
 arch/arm/boot/dts/atlas7.dtsi    |   97 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 111 insertions(+), 4 deletions(-)

-barry
