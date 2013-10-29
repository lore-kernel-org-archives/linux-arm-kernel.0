From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 30 Oct 2013 02:49:09 +0800
Subject: [GIT PULL]ARM: sirf: dts update for 3.13
Message-ID: <CAGsJ_4z0xLZE5yfaQqVnVne8zn=D13UxmWb8P6pknPNcQ9p14A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Oolf,

as discussed at "[GIT PULL]ARM: sirf: dts fixes for 3.12-rc"
http://www.spinics.net/lists/arm-kernel/msg276335.html

some CSR SiRFSoC dts changes are queued for 3.13 here.

-barry

The following changes since commit 959f58544b7f20c92d5eb43d1232c96c15c01bfb:

  Linux 3.12-rc7 (2013-10-27 16:12:03 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/baohua/linux.git
tags/sirf-dts-for-3.13

for you to fetch changes up to 6b4e51e09de47c9d7fe3eccde339e1e61001bce3:

  ARM: dts: sirf: add missed address-cells and size-cells for prima2
I2C (2013-10-30 02:31:51 +0800)

----------------------------------------------------------------
ARM: sirf: dts update for 3.13

some missed dt nodes for sirf dts for 3.13. Among them:
  - add missed chhifbg node in prima2 and atlas6 dts
  - add missed cell, cs and dma channel for SPI nodes
  - add missed graphics2d iobg in atlas6 dts
  - add missed address-cells and size-cells for prima2 I2C
  - add missed memcontrol-monitor node in prima2 and atlas6 dts

----------------------------------------------------------------
Barry Song (2):
      ARM: dts: sirf: add missed chhifbg node in prima2 and atlas6 dts
      ARM: dts: sirf: add missed cell, cs and dma channel for SPI nodes

Jiansong Chen (1):
      ARM: dts: sirf: add missed graphics2d iobg in atlas6 dts

Renwei Wu (1):
      ARM: dts: sirf: add missed address-cells and size-cells for prima2 I2C

Ye He (1):
      ARM: dts: sirf: add missed memcontrol-monitor node in prima2 and
atlas6 dts

 arch/arm/boot/dts/atlas6.dtsi | 33 ++++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/prima2.dtsi | 30 +++++++++++++++++++++++++++++-
 2 files changed, 61 insertions(+), 2 deletions(-)
