From: shawn.gsc@gmail.com (Shawn Guo)
Date: Thu, 16 Dec 2010 18:26:30 +0800
Subject: [PATCH v6 08/15] ARM: mxs: Add iomux support
In-Reply-To: <20101216095105.GG1940@pengutronix.de>
References: <1292244903-30392-1-git-send-email-shawn.guo@freescale.com>
	<1292244903-30392-6-git-send-email-shawn.guo@freescale.com>
	<20101216095105.GG1940@pengutronix.de>
Message-ID: <AANLkTim=p=bDTAwyPQxdnte29t6m5xQp306ghz2pNpoe@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

2010/12/16 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
[...]
>
> Can we please have a defined order for these definitions? ?I suggest to
> sort by the arguments to MXS_IOMUX_PAD.
>
> Moreover to be able to benefit from iomux_cfg_t being an integer type it
> would be great to have the generic defines use PAD_VOL_NONE, PAD_MA_NONE
> and PAD_NOPULL and let these constants have the value 0 to be able to
> simply say:
>
> ? ? ? ?static const mxs_iomux_cfg_t my_pads[] = {
> ? ? ? ? ? ? ? ?MX28_PAD_SSP1_DATA3__GPIO_2_15 | PAD_PULLUP,
> ? ? ? ? ? ? ? ?...
> ? ? ? ?};
>
> And it would be nice to get all pad definitions at once generated from
> the Freescale Excel sheet. ?Lothar Wa?mann already did that based on one
> of your first versions of this series. ?I can provide it to you via
> private mail if you think this might be easier for you. ?For plat-mxc

OK. Please send me.

> starting with the complete definitions prooved to be the better approach
> because otherwise you get many merge conflicts and typing errors.
>
> BTW, when Lothar did the conversion he found one mismatch between your
> patch and the Excel sheet. ?You had MX28_PAD_ENET_CLK__ENET_CLK while
> the table had MX28_PAD_ENET_CLK__CLKCTRL_ENET. ?I didn't check which of
> these is consistent with the reference manual.
>

Excel is correct.

> (Most of these suggestions are from Lothar, I'm just the messenger here,
> but I'm of the same mind.)
>

Thanks, both.


-- 
Regards,
Shawn
