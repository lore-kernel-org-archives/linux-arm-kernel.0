From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 25 Nov 2014 11:05:41 +0800
Subject: [GIT PULL] CSR SiRFSOC DT for 3.19
Message-ID: <CAGsJ_4yC8bStnYx3ramD=OXA03oihUEwCgcfqsStfWx2rasMqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,
The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  gitolite.kernel.org:/pub/scm/linux/kernel/git/baohua/linux.git
tags/sirf-dts-for-3.19

for you to fetch changes up to 294a212faa5bf7cb48fabccec5ee13e836e29ecb:

  ARM: dts: atlas6: add resets property for SPI nodes (2014-11-25
18:46:43 +0800)

----------------------------------------------------------------
change pinmux pingroup and add some lost node/prop

1. add resets properity for some nodes;
2. change pinctrl groups for audio
3. add PMU node

----------------------------------------------------------------
Qipan Li (1):
      ARM: dts: atlas6: add resets property for SPI nodes

Renwei Wu (2):
      ARM: dts: prima2: add resets property for VPP nodes
      ARM: dts: atlas6: add resets property for VPP nodes

Rongjun Ying (3):
      ARM: dts: prima2: add I2S 2ch, 6ch, nodin, mclk groups
      ARM: dts: atlas6: add a separate pingroup for i2s mclk output
      ARM: dts: atlas6: Add I2S external clock input pingroup

Tao Huang (1):
      ARM: dts: prima2: add resets property for GPS nodes

Ye He (1):
      ARM: dts: prima2: add node for Performance Monitor Unit

 arch/arm/boot/dts/atlas6.dtsi |   15 +++++++++++++++
 arch/arm/boot/dts/prima2.dtsi |   33 +++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

-barry
