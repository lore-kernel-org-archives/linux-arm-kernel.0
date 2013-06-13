From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 13 Jun 2013 23:37:06 +0200
Subject: ARM: sunxi: DT changes for 3.11
Message-ID: <20130613213706.GA22048@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:

  Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)

are available in the git repository at:

  git://github.com/mripard/linux.git tags/sunxi-dt-for-3.11

for you to fetch changes up to 39138bc60f90560ac79e76fb0971be5619ae32d7:

  ARM: sunxi: dt: Register the pio node as interrupt controller (2013-06-10 17:35:51 +0200)

----------------------------------------------------------------
Allwinner SoCs DT additions for 3.11
  - Switch to using the sun5i clocks for the A13
  - Register the pio node as an interrupt controller

----------------------------------------------------------------
Maxime Ripard (2):
      ARM: sun5i: Update the clock compatible strings
      ARM: sunxi: dt: Register the pio node as interrupt controller

 arch/arm/boot/dts/sun4i-a10.dtsi |  2 ++
 arch/arm/boot/dts/sun5i-a13.dtsi | 37 ++++++++++++++-----------------------
 2 files changed, 16 insertions(+), 23 deletions(-)

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
