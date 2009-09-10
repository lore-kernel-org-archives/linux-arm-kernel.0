From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 10 Sep 2009 19:46:26 +0800
Subject: What's inside the pxa tree for this merge window
Message-ID: <f17812d70909100446h17a1903fy74941945dbfc6943@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's the preview of request-pull result, please let me know if there
is anything missed, thanks.

URL: git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git

Alex Roman (1):
      [ARM] pxa/colibri: add UART MFP configuration for the PXA320 module

Aric D. Blumer (1):
      USB: ohci-pxa27x: Reconfigure power settings on resume

Daniel Mack (6):
      [ARM] pxa: add MFP_PULL_FLOAT
      [ARM] pxa: add clock definition for graphics controller
      [ARM] pxa: add device definition for graphics controller
      [ARM] pxa: rename GCU IRQ for consistency
      [ARM] pxafb: use resource_size() function
      [ARM] pxa/colibri: add NAND config for Colibri PXA3xx boards

Daniel Ribeiro (1):
      [ARM] pxa/ezx: set IRQ_BOARD_END for EZX

Eric Miao (3):
      [ARM] pxa/littleton: update littleton to use the new
gpio_card_detect for mmc
      [ARM] pxa/corgi: make use of GPIO based matrix keypad driver
      [ARM] pxa/spitz: make use of GPIO based matrix keypad driver

Guennadi Liakhovetski (3):
      [ARM] pxa/pcm990: convert pcm990 to soc-camera as platform-device
      [ARM] pxa/mioa701: convert mioa701 to the new platform-device
soc-camera interface
      [ARM] pxa/em-x270: convert em-x270 to soc-camera as platform-device

Haojian Zhuang (10):
      [ARM] pxa: remove duplicate mfp definition in mach
      [ARM] pxa: support mfp of pxa935
      [ARM] pxa: expand irq support for PXA93x and PXA950
      [ARM] pxa: update cpu_is_xsc3() to include Marvell CPUID
      [ARM] pxa: add cpu_is_pxa950() and Kconfig options
      [ARM] pxa: add more registers in interrupt controller
      [ARM] pxa: initialize default interrupt priority and use ICHP
for IRQ handling
      [ARM] pxa: update dependancy of pxa i2c module
      [ARM] pxa: merge {zylonite,littleton}_defconfig into pxa3xx_defconfig
      [ARM] pxa: update rtc-sa1100.c to use 'struct dev_pm_ops'

Jonathan McDowell (1):
      [ARM] pxa: balloon3 (http://balloonboard.org/) base machine support

Marek Vasut (9):
      [ARM] pxa/palm: add detect_delay to mmc for PalmTX,T5,LD
      [ARM] pxa/palm: Add NOR flash support for PalmLD
      [ARM] pxa/palm: add NAND Flash support for PalmTX
      [ARM] pxa/palm: Add NOR Flash support for PalmTX
      [ARM] pxa: Palm Tungsten|C initial support
      [ARM] pxa: Palm Tungsten|C PCMCIA support
      [ARM] pxa/palm: fix possibly uninitialized variable in PalmTC-pcmcia
      [ARM] pxa: add gpio_pwdown(_inverted) into pxaficp_ir.c
      MAINTAINERS: fix mailing list entries for ARM/Palm devices

Matej Kenda (2):
      [ARM] pxa: add support for the IskraTel XCEP board
      [ARM] pxa: add defconfig for IskraTel XCEP board

Mike Rapoport (11):
      [ARM] pxa/em-x270: remove debug leftovers
      [ARM] pxa/em-x270: add vcc_core regulator
      [ARM] pxa/cm-x270: add libertas device registration
      [ARM] pxa: update da903x_bl.c to use 'struct dev_pm_ops'
      [ARM] pxa: update pxa serial driver to use 'struct dev_pm_ops'
      [ARM] pxa: update ohci-pxa27x.c to use 'struct dev_pm_ops'
      [ARM] pxa: update pxa2xx-spi.c to use 'struct dev_pm_ops'
      [ARM] pxa: update pxafb.c to use 'struct dev_pm_ops'
      [ARM] pxa: update pxa2xx-ac97.c to use 'struct dev_pm_ops'
      [ARM] pxa: update pxamci.c to use 'struct dev_pm_ops'
      [ARM] pxa: update pcmcia/pxa2xx_base.c to use 'struct dev_pm_ops'

Philipp Zabel (2):
      [ARM] pxa: remove left-over struct clk *other field from struct clk
      [ARM] pxa/hx4700: use platform_lcd driver

Robert Jarzmik (6):
      [ARM] pxa/dma: cosmetic move of EXPORT_SYMBOL under their functions
      [ARM] pxa/dma: optimize irq handler loop
      [ARM] pxa/dma: add debugfs entries
      [ARM] pxamci: add simple gpio controls
      [ARM] pxa: factor pxamci gpio handling
      [ARM] pxa: update rtc-pxa.c to use 'struct dev_pm_ops'

Tom?? ?ech (1):
      [ARM] pxa/treo680: move LCD power GPIO to proper place

walker at suse.cz (1):
      [ARM] pxa/treo680: pxamci simplify to use GPIO
