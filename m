From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 28 Jul 2015 09:03:54 +0000
Subject: [PATCH 00/10] ARM: dts: atlas7: add some missed nodes and properties
Message-ID: <1438074244-18708-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>


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
  ARM: dts: atlas7: add software digital radio nodes and its DMA
    channels

 arch/arm/boot/dts/atlas7-evb.dts | 18 ++++++++
 arch/arm/boot/dts/atlas7.dtsi    | 97 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 111 insertions(+), 4 deletions(-)

-- 
1.9.1
