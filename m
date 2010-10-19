From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 19 Oct 2010 17:20:32 +0200
Subject: Pull request for i.MX
In-Reply-To: <20101019142153.GV28242@pengutronix.de>
References: <20101019142153.GV28242@pengutronix.de>
Message-ID: <20101019152031.GD2622@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Tue, Oct 19, 2010 at 04:21:53PM +0200, Sascha Hauer wrote:
> Hi Russell,
> 
> Please pull the seocnd bunch of patches for the next merge window
> 
> Sascha
> 
> The following changes since commit b9969f6525c9c00b042441acb0e1c0ee95560b63:
> 
>   Merge branch 'devel-stable' into devel (2010-10-18 22:34:52 +0100)
> 
> are available in the git repository at:
> 
>   git://git.pengutronix.de/git/imx/linux-2.6.git for-rmk
> 
> Dinh Nguyen (1):
>       ARM: imx: Add iram allocator functions
> 
> Eric B?nard (28):
>       mx25: fix clock's calculation
>       mx25: fix compile error in platform-imx-dma.c
>       i.MX31 and i.MX35 : fix errate TLSbo65953 and ENGcm09472
>       cpuimx25 & cpuimx35: fix OTG port registration in host mode
>       eukrea_mbimxsd: add support for DVI displays
>       clock-mx51: factorize clk_set_parent and clk_get_rate
>       clock-mx51: rename CLOCK1 to CLOCK_CCGR for better readability
>       iomux-mx51: fix SD1 and SD2's iomux configuration
>       mx51: add resources for SD/MMC on i.MX51
>       imx-esdhc: update devices registration
>       iomux-mx51: fix GPIO_1_xx 's IOMUX configuration
>       mx5: add cpuimx51sd module and its baseboard
>       cpuimx51: update board support
>       mach-pcm037_eet: fix compile errors
>       cpuimx27: fix compile when ULPI is selected
>       mx25: fix clock's calculation
>       mx25: fix compile error in platform-imx-dma.c
>       i.MX31 and i.MX35 : fix errate TLSbo65953 and ENGcm09472
>       cpuimx25 & cpuimx35: fix OTG port registration in host mode
>       eukrea_mbimxsd: add support for DVI displays
>       clock-mx51: factorize clk_set_parent and clk_get_rate
>       clock-mx51: rename CLOCK1 to CLOCK_CCGR for better readability
>       iomux-mx51: fix SD1 and SD2's iomux configuration
>       mx51: add resources for SD/MMC on i.MX51
>       imx-esdhc: update devices registration
>       iomux-mx51: fix GPIO_1_xx 's IOMUX configuration
>       mx5: add cpuimx51sd module and its baseboard
>       cpuimx51: update board support

For some reason the first 13 commits appear twice in this list. Is this 
intended?

> Fabio Estevam (1):
>       eukrea_mbimxsd-baseboard: Pass the correct GPIO to gpio_free
> 
> Ian Lartey (2):
>       Fixing ethernet driver compilation error for i.MX31 ADS board
>       Fixing ethernet driver compilation error for i.MX31 ADS board

again.

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
