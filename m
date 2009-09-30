From: rpjday@crashcourse.ca (Robert P. J. Day)
Date: Wed, 30 Sep 2009 11:27:14 -0400 (EDT)
Subject: list of apparently(?) un-included header files under arch/arm 
Message-ID: <alpine.LFD.2.00.0909301126360.18347@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


  here's the entire list of (apparently) un-included header files
under the arch/arm directory, where un-included is defined to mean not
explicitly included via a "#include" directive somewhere (which means
there could still be false positives if they're being pulled into
Makefiles).  so treat with caution, but a random sampling on my part
seems to show that most of them really aren't being used, for whatever
reason.  enjoy.

./arch/arm/include/asm/hardware/linkup-l1110.h
./arch/arm/mach-at91/include/mach/at91_adc.h
./arch/arm/mach-at91/include/mach/at91_spi.h
./arch/arm/mach-at91/include/mach/at91_ssc.h
./arch/arm/mach-l7200/include/mach/aux_reg.h
./arch/arm/mach-l7200/include/mach/gp_timers.h
./arch/arm/mach-l7200/include/mach/pmpcon.h
./arch/arm/mach-l7200/include/mach/serial_l7200.h
./arch/arm/mach-l7200/include/mach/sib.h
./arch/arm/mach-l7200/include/mach/sys-clock.h
./arch/arm/mach-pxa/include/mach/eseries-irq.h
./arch/arm/mach-s3c2410/include/mach/bast-pmu.h
./arch/arm/mach-sa1100/include/mach/lart.h
./arch/arm/mach-sa1100/include/mach/SA-1111.h
./arch/arm/mach-stmp378x/include/mach/regs-audioin.h
./arch/arm/mach-stmp378x/include/mach/regs-audioout.h
./arch/arm/mach-stmp378x/include/mach/regs-bch.h
./arch/arm/mach-stmp378x/include/mach/regs-dcp.h
./arch/arm/mach-stmp378x/include/mach/regs-digctl.h
./arch/arm/mach-stmp378x/include/mach/regs-dram.h
./arch/arm/mach-stmp378x/include/mach/regs-dri.h
./arch/arm/mach-stmp378x/include/mach/regs-ecc8.h
./arch/arm/mach-stmp378x/include/mach/regs-emi.h
./arch/arm/mach-stmp378x/include/mach/regs-ir.h
./arch/arm/mach-stmp378x/include/mach/regs-lradc.h
./arch/arm/mach-stmp378x/include/mach/regs-ocotp.h
./arch/arm/mach-stmp378x/include/mach/regs-pwm.h
./arch/arm/mach-stmp378x/include/mach/regs-saif.h
./arch/arm/mach-stmp378x/include/mach/regs-spdif.h
./arch/arm/mach-stmp378x/include/mach/regs-sydma.h
./arch/arm/mach-stmp378x/include/mach/regs-tvenc.h
./arch/arm/mach-stmp378x/include/mach/regs-uartdbg.h
./arch/arm/mach-stmp378x/include/mach/regs-usbphy.h
./arch/arm/mach-stmp37xx/include/mach/regs-audioin.h
./arch/arm/mach-stmp37xx/include/mach/regs-audioout.h
./arch/arm/mach-stmp37xx/include/mach/regs-digctl.h
./arch/arm/mach-stmp37xx/include/mach/regs-ecc8.h
./arch/arm/mach-stmp37xx/include/mach/regs-lradc.h
./arch/arm/mach-stmp37xx/include/mach/regs-pwm.h
./arch/arm/mach-stmp37xx/include/mach/regs-uartdbg.h
./arch/arm/mach-stmp37xx/include/mach/regs-usbctl.h
./arch/arm/mach-stmp37xx/include/mach/regs-usbphy.h
./arch/arm/mach-w90x900/include/mach/regs-usb.h
./arch/arm/plat-mxc/include/mach/board-mx35pdk.h
./arch/arm/plat-mxc/include/mach/board-pcm043.h
./arch/arm/plat-mxc/include/mach/iim.h
./arch/arm/plat-omap/include/mach/board-voiceblue.h
./arch/arm/plat-omap/include/mach/omap850.h
./arch/arm/plat-s3c64xx/include/plat/gpio-bank-a.h
./arch/arm/plat-s3c64xx/include/plat/gpio-bank-c.h
./arch/arm/plat-s3c64xx/include/plat/gpio-bank-f.h
./arch/arm/plat-s3c64xx/include/plat/gpio-bank-g.h
./arch/arm/plat-s3c64xx/include/plat/gpio-bank-h.h
./arch/arm/plat-s3c64xx/include/plat/gpio-bank-i.h
./arch/arm/plat-s3c64xx/include/plat/gpio-bank-j.h
./arch/arm/plat-s3c64xx/include/plat/gpio-bank-o.h
./arch/arm/plat-s3c64xx/include/plat/gpio-bank-p.h
./arch/arm/plat-s3c64xx/include/plat/gpio-bank-q.h

rday
--

========================================================================
Robert P. J. Day                               Waterloo, Ontario, CANADA

        Linux Consulting, Training and Annoying Kernel Pedantry.

Web page:                                          http://crashcourse.ca
Twitter:                                       http://twitter.com/rpjday
========================================================================
