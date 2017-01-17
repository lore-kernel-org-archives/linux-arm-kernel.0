From: eric@anholt.net (Eric Anholt)
Date: Tue, 17 Jan 2017 21:10:43 +1100
Subject: [GIT PULL] bcm2835-dt-next-2017-01-17
Message-ID: <20170117101043.28802-1-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  https://github.com/anholt/linux tags/bcm2835-dt-next-2017-01-17

for you to fetch changes up to 38742ca2b8b21bfc2a2cc24278b58485ff781644:

  ARM: bcm/dt: Enable the VEC IP on all RaspberryPi boards (2017-01-16 21:50:26 +1100)

----------------------------------------------------------------
This pull request brings in the DT changes for VEC (TV-out) on
Raspberry Pi.

----------------------------------------------------------------
Boris Brezillon (2):
      ARM: bcm/dt: Add VEC node in bcm283x.dtsi
      ARM: bcm/dt: Enable the VEC IP on all RaspberryPi boards

 arch/arm/boot/dts/bcm2835-rpi.dtsi | 5 +++++
 arch/arm/boot/dts/bcm283x.dtsi     | 8 ++++++++
 2 files changed, 13 insertions(+)
