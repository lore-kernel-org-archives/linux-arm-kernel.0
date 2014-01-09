From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 9 Jan 2014 20:20:06 +0800
Subject: [GIT PULL]ARM: sirf: dts update for 3.14
Message-ID: <CAGsJ_4yx=U2dQ6ZkGAtvEwUPdWRwotJae8Sk+g+gqczV0JEo0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,
The following changes since commit 374b105797c3d4f29c685f3be535c35f5689b30e:

  Linux 3.13-rc3 (2013-12-06 09:34:04 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/baohua/linux.git
tags/sirf-dts-for-3.14

for you to fetch changes up to 73f68c01f468f072776d98f6bbf7fb367a1f2540:

  ARM: dts: SiRF: add pin group for USP0 with only RX or TX frame sync
(2014-01-09 20:05:31 +0800)

----------------------------------------------------------------
ARM: sirf: dts update for 3.14

some missed dt nodes or props for sirf dts for 3.14.
Among them:
 - add lost clocks for cphifbg
 - add lost bus_width, clock and status for sdhci
 - add clock, frequence-voltage table for CPU0
 - add lost minigpsrtc device node
 - add lost usp1_uart_nostreamctrl pin group for atlas6
 - add pin group for USP0 with only RX or TX frame sync

----------------------------------------------------------------
Barry Song (1):
      ARM: dts: sirf: add lost clocks for cphifbg

Bin Shi (1):
      ARM: dts: sirf: add lost bus_width, clock and status for sdhci

Qipan Li (1):
      ARM: dts: sirf: add lost usp1_uart_nostreamctrl pin group for atlas6

Rongjun Ying (2):
      ARM: dts: sirf: add clock, frequence-voltage table for CPU0
      ARM: dts: sirf: add pin group for USP0 with only RX or TX frame sync

Xianglong Du (1):
      ARM: dts: sirf: add lost minigpsrtc device node

 arch/arm/boot/dts/atlas6.dtsi |   26 ++++++++++++++++++++++++++
 arch/arm/boot/dts/prima2.dtsi |   41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

-barry
