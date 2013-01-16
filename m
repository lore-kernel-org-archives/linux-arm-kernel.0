From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 16 Jan 2013 19:23:36 +0100
Subject: [GIT PULL] sunxi fixes for 3.8
Message-ID: <50F6F028.6060009@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd,

Please consider pulling the following patch for 3.8.

The sunxi UARTs are actually not a regular 8250 but rather uses a
Synopsys DPB compatible UART.

This patch fixes that.

Thanks,
Maxime

The following changes since commit 43880f709dc59840849e31b01735ac587195ef8a:

  sunxi: Change the machine compatible string. (2012-12-23 18:20:15 +0100)

are available in the git repository at:

  git://github.com/mripard/linux.git tags/sunxi-fixes-for-3.8-rc4

for you to fetch changes up to 1bea07f16da0d77689cda7abe73939dd1dfdea22:

  ARM: sunxi: Use the Synosys APB UART instead of ns8250 (2013-01-16 19:13:18 +0100)

----------------------------------------------------------------
Sunxi dt fixes for 3.8-rc's

----------------------------------------------------------------
Maxime Ripard (1):
      ARM: sunxi: Use the Synosys APB UART instead of ns8250

 arch/arm/boot/dts/sunxi.dtsi |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
