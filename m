From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 21 Nov 2012 11:12:59 +0100
Subject: [PATCH 0/2] gpio: dt: add gpio-export support
Message-ID: <20121121101259.GQ4398@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI,

	This patch serie add the support of gpio-export to DT

	This also extend to gpio_export with the possibility to specify a name
	for the gpio.
	When you support different hardware you do not need to knwon which gpio
	is used at application level just you have it

	based on next-20121115 tested on AT91 Animeo IP

  gpiolib-of: ad gpio-export support (2012-11-19 20:36:03 +0800)

----------------------------------------------------------------
Jean-Christophe PLAGNIOL-VILLARD (2):
      gpiolib: add gpio_export_with_name
      gpiolib-of: ad gpio-export support

 Documentation/devicetree/bindings/gpio/gpio.txt |   60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/mips/include/asm/mach-au1x00/gpio-au1000.h |    3 ++-
 arch/mips/include/asm/mach-au1x00/gpio-au1300.h |    3 ++-
 drivers/gpio/gpiolib-of.c                       |   61 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/gpio/gpiolib.c                          |   12 +++++++-----
 include/asm-generic/gpio.h                      |    6 ++++--
 include/linux/gpio.h                            |   23 ++++++++++++++++++++++-
 7 files changed, 158 insertions(+), 10 deletions(-)

Best Regards,
J.
