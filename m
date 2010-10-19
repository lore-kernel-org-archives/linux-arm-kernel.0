From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 19 Oct 2010 17:37:43 +0200
Subject: Pull request for i.MX
In-Reply-To: <20101019152031.GD2622@jasper.tkos.co.il>
References: <20101019152031.GD2622@jasper.tkos.co.il>
Message-ID: <20101019153743.GW28242@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 19, 2010 at 05:20:32PM +0200, Baruch Siach wrote:
> >       cpuimx51: update board support
> >       mach-pcm037_eet: fix compile errors
> >       cpuimx27: fix compile when ULPI is selected
> >       mx25: fix clock's calculation
> >       mx25: fix compile error in platform-imx-dma.c
> >       i.MX31 and i.MX35 : fix errate TLSbo65953 and ENGcm09472
> >       cpuimx25 & cpuimx35: fix OTG port registration in host mode
> >       eukrea_mbimxsd: add support for DVI displays
> >       clock-mx51: factorize clk_set_parent and clk_get_rate
> >       clock-mx51: rename CLOCK1 to CLOCK_CCGR for better readability
> >       iomux-mx51: fix SD1 and SD2's iomux configuration
> >       mx51: add resources for SD/MMC on i.MX51
> >       imx-esdhc: update devices registration
> >       iomux-mx51: fix GPIO_1_xx 's IOMUX configuration
> >       mx5: add cpuimx51sd module and its baseboard
> >       cpuimx51: update board support
> 
> For some reason the first 13 commits appear twice in this list. Is this 
> intended?

Because I merged Uwes branch into mine. I'll fix this once I'm at home

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
