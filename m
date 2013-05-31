From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 31 May 2013 22:56:52 +0200
Subject: [PATCH 0/5] ARM: at91: Calao USB-A926x switch completyl to dt
 and drop board file
In-Reply-To: <20130526153037.GQ24476@game.jcrosoft.org>
References: <20130526153037.GQ24476@game.jcrosoft.org>
Message-ID: <51A90E94.6010404@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/05/2013 17:30, Jean-Christophe PLAGNIOL-VILLARD :
> Hi,
>
> 	The Follwing patch serie finish to swtich the Calao USB-A926x to DT
> 	and drop the board file.
>
> 	This is the first boards to be drop on at91
>
> The following changes since commit 24577c1b3ebf3eab6465bb112a6265e87400163e:
>
>    ARM: at91: dt: sam9260: add i2c gpio pinctrl (2013-05-26 16:56:39 +0800)
>
> are available in the git repository at:
>
>    git://github.com/at91linux/linux-at91.git j/for-3.11-calao-dt

Whole series added to the at91-3.11-dt branch.

Thanks for this move forward!

Bye,

> for you to fetch changes up to c3ea1d2cc2f543ee0646a75890e1a7be5dd82c0b:
>
>    ARM: at91: drop non DT: Calao USB-A96x (2013-05-26 23:32:23 +0800)
>
> ----------------------------------------------------------------
> Jean-Christophe PLAGNIOL-VILLARD (5):
>        ARM: at91: dt: usb-a9260: update shutdown controller
>        ARM: at91: dt: usb-a9263: update shutdown controller
>        ARM: at91: dt: usb-a9263: add dataflash support
>        ARM: at91: dt: add Calao USB-A9G20 low power version
>        ARM: at91: drop non DT: Calao USB-A96x
>
>   arch/arm/boot/dts/Makefile                  |    1 +
>   arch/arm/boot/dts/usb_a9260.dts             |    9 ++++++
>   arch/arm/boot/dts/usb_a9263.dts             |   14 +++++++++
>   arch/arm/boot/dts/usb_a9g20.dts             |   18 +----------
>   arch/arm/boot/dts/usb_a9g20_common.dtsi     |   27 ++++++++++++++++
>   arch/arm/boot/dts/usb_a9g20_lpw.dts         |   31 ++++++++++++++++++
>   arch/arm/configs/at91_dt_defconfig          |    2 ++
>   arch/arm/configs/at91sam9260_9g20_defconfig |    1 -
>   arch/arm/configs/at91sam9263_defconfig      |    1 -
>   arch/arm/mach-at91/Kconfig.non_dt           |   19 -----------
>   arch/arm/mach-at91/Makefile                 |    3 --
>   arch/arm/mach-at91/board-usb-a926x.c        |  384 ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
>   12 files changed, 85 insertions(+), 425 deletions(-)
>   create mode 100644 arch/arm/boot/dts/usb_a9g20_common.dtsi
>   create mode 100644 arch/arm/boot/dts/usb_a9g20_lpw.dts
>   delete mode 100644 arch/arm/mach-at91/board-usb-a926x.c
>
> Best Regards,
> J.
>


-- 
Nicolas Ferre
