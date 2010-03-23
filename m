From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Tue, 23 Mar 2010 19:42:21 +0100
Subject: [PATCH 0/8] MXC: mach-mx31_3ds: Patch series that enable the
	support for Freescale i.MX31 3-Stack development board.
Message-ID: <1269369741.3276.162.camel@realization>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series build the mainline architecture support for the Freescale i.MX31 3-Stack 
development board since all the drivers needed are merged in mainline from
the first 2.6.34 release candidate.

[PATCH 1/8] MXC: mach-mx31_3ds: Update variable names over recent mach name modification.

[PATCH 2/8] MXC: mach-mx31_3ds: Add support for on board NAND Flash.

[PATCH 3/8] MXC: mach-mx31_3ds: Add SPI1 device support.

[PATCH 4/8] MXC: mach-mx31_3ds: add support for freescale mc13783 power management device.

[PATCH 5/8] MXC: mach-mx31_3ds: Add support for SD card slot in the personality board.

[PATCH 6/8] MXC: mach-mx31_3ds: Add support for framebuffer and lcd.

[PATCH 7/8] MXC: mach-mx31_3ds: Add support for the keypad.

[PATCH 8/8] MXC: mach-mx31_3ds: enable mc13783 touchscreen interface.

Comments and/or suggestion are welcome.

Best Regards,

-- 
Alberto!

        Be Persistent!
                - Greg Kroah-Hartman (FOSDEM 2010)
