From: dinguyen@altera.com (dinguyen at altera.com)
Date: Wed, 28 Aug 2013 17:38:48 -0500
Subject: [GIT PULL] arm: dts: SOCFPGA updates for v3.12
Message-ID: <1377729528-24305-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

Hi Olof/Kevin,

This is my first pull request to you guys, so I apologize in advance if
something is not correct.

Here is a short description of the ACKs for the 3 patches:
of: add vendor prefix for Altera Corp.
	Acked-by: Mark Rutland <mark.rutland@arm.com>
	Acked-by: Stephen Warren <swarren@wwwdotorg.org>
dts: Deprecate ALTR as a vendor prefix
	Acked-by: Stephen Warren <swarren@wwwdotorg.org>
arm: dts: Change dw-apb-timer-osc and dw-apb-timer-sp to just dw-apb-timer
	Acked-by: Stephen Warren <swarren@wwwdotorg.org>

Thanks,
Dinh
--------------------------------------------------------------

The following changes since commit fa8218def1b1a16f0a410e2c1c767b4738cc81fa:

  Merge tag 'regmap-v3.11-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap (2013-08-27 10:10:30 -0700)

are available in the git repository at:


  git://git.rocketboards.org/linux-socfpga-next.git next-dt

for you to fetch changes up to 4d4dd417b8c0ba99c68038ccf2d0256dcd460ead:

  arm: dts: Change dw-apb-timer-osc and dw-apb-timer-sp to  just dw-apb-timer (2013-08-28 17:11:25 -0500)

---------------------------------------------------------------
SOCFPGA DT changes for v3.12 merge window.

----------------------------------------------------------------
Dinh Nguyen (3):
      of: add vendor prefix for Altera Corp.
      dts: Deprecate ALTR as a vendor prefix
      arm: dts: Change dw-apb-timer-osc and dw-apb-timer-sp to      just dw-apb-timer

 Documentation/devicetree/bindings/rtc/dw-apb.txt   |   34 +++++++-------------
 .../devicetree/bindings/serial/altera_jtaguart.txt |    3 +-
 .../devicetree/bindings/serial/altera_uart.txt     |    3 +-
 .../devicetree/bindings/serio/altera_ps2.txt       |    3 +-
 .../devicetree/bindings/spi/spi_altera.txt         |    3 +-
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 arch/arm/boot/dts/socfpga.dtsi                     |    8 ++---
 drivers/input/serio/altera_ps2.c                   |    1 +
 drivers/spi/spi-altera.c                           |    1 +
 drivers/tty/serial/altera_jtaguart.c               |    1 +
 drivers/tty/serial/altera_uart.c                   |    1 +
 11 files changed, 28 insertions(+), 31 deletions(-)
