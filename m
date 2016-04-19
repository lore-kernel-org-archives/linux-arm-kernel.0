From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Tue, 19 Apr 2016 16:02:20 +0200
Subject: SoCFPGA with CONFIG_THUMB2_KERNEL boot error
Message-ID: <20160419140220.GA9503@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

According to kernelci.org (and validating on my own hardware), the current
socfpga mainline kernel has an issue with CONFIG_THUMB2_KERNEL enabled.

https://storage.kernelci.org/mainline/v4.6-rc4-11-g12566cc35d0e/arm-multi_v7_defconfig/lab-khilman/boot-socfpga_cyclone5_de0_sockit.html

vs

https://storage.kernelci.org/mainline/v4.6-rc4-11-g12566cc35d0e/arm-multi_v7_defconfig+CONFIG_THUMB2_KERNEL=y/lab-khilman/boot-socfpga_cyclone5_de0_sockit.html

Both boot successfully, but notice that the board fails to bring up CPU1 if
thumb2 support is enabled.

Any ideas why this might be happening?

Regards,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
