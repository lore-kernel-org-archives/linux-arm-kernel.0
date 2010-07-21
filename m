From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 21 Jul 2010 07:42:39 +0300
Subject: [PATCH 3/3] i.MX51: add support for cpuimx51 module and its
	baseboard
In-Reply-To: <1279610174-6025-3-git-send-email-eric@eukrea.com>
References: <1279610174-6025-1-git-send-email-eric@eukrea.com>
	<1279610174-6025-2-git-send-email-eric@eukrea.com>
	<1279610174-6025-3-git-send-email-eric@eukrea.com>
Message-ID: <20100721044239.GC31367@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On Tue, Jul 20, 2010 at 09:16:14AM +0200, Eric B?nard wrote:
> CPUIMX51 is build around Freescale's i.MX515 and has up to
> 512MB of RAM, NAND Flash, Ethernet, USB Host with 4 ports
> hub, USB OTG, ST16554 Quad UART on nCS1, I2C RTC ...
> 
> MBIMX51 adds LEDS, Keypad, TSC2007 touchscreen controler ...
> 
> Signed-off-by: Eric B?nard <eric@eukrea.com>
> ---
>  arch/arm/mach-mx5/Kconfig                          |   21 ++
>  arch/arm/mach-mx5/Makefile                         |    2 +
>  arch/arm/mach-mx5/board-cpuimx51.c                 |  299 ++++++++++++++++++++
>  arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c       |  200 +++++++++++++
>  .../plat-mxc/include/mach/board-eukrea_cpuimx51.h  |   37 +++
>  5 files changed, 559 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-mx5/board-cpuimx51.c
>  create mode 100644 arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c
>  create mode 100644 arch/arm/plat-mxc/include/mach/board-eukrea_cpuimx51.h
> 
> diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
> index 6ef3428..5edd07e 100644
> --- a/arch/arm/mach-mx5/Kconfig
> +++ b/arch/arm/mach-mx5/Kconfig
> @@ -21,4 +21,25 @@ config MACH_MX51_3DS
>  	help
>  	  Include support for MX51PDK (3DS) platform. This includes specific
>  	  configurations for the board and its peripherals.
> +
> +config MACH_EUKREA_CPUIMX51
> +	bool "Support Eukrea CPUIMX51 module"
> +	help
> +	  Include support forEukrea CPUIMX27 platform. This includes

s/CPUIMX27/CPUIMX51/

> +	  specific configurations for the module and its peripherals.
> +

[snip]

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
