From: 21cnbao@gmail.com (Barry Song)
Date: Fri, 9 May 2014 21:53:39 +0800
Subject: [GIT PULL]]ARM: sirf: dts update for 3.16
Message-ID: <CAGsJ_4waeAPJjnKiuXBJXXF-bYud=uO_j1hrS9auBAGr8KcFiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof, Kevin,

The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/baohua/linux.git
tags/sirf-dts-for-3.16

for you to fetch changes up to b01c5905c29d7d5748a24267bb2486e4a1605fda:

  ARM: dts: sirf: add resets for dspif, gps and dsp nodes (2014-05-08
14:13:08 +0800)

----------------------------------------------------------------
some minor cleanup and add some missed nodes:
1. move dma channel descriptions to generic dma properity;
2. add resets properity for some nodes;
3. add missed pinctrl groups.

----------------------------------------------------------------
Barry Song (1):
      ARM: dts: sirf: move to use generic dma dt-binding for spi

Rongjun Ying (1):
      ARM: dts: sirf: add pin group for USP0 with only RX or TX frame
sync for atlas6

Tao Huang (1):
      ARM: dts: sirf: add resets for dspif, gps and dsp nodes

Ye He (1):
      ARM: dts: atlas6: add cortex-a9-pmu compatible PMU node

 arch/arm/boot/dts/atlas6.dtsi |   31 ++++++++++++++++++++++++++-----
 arch/arm/boot/dts/prima2.dtsi |   10 ++++++----
 2 files changed, 32 insertions(+), 9 deletions(-)


-barry
