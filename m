From: 21cnbao@gmail.com (Barry Song)
Date: Fri, 12 Jul 2013 11:39:46 +0800
Subject: [PATCH 04/12] drivers/mmc/host: don't use
 devm_pinctrl_get_select_default() in probe
In-Reply-To: <1373471889-18107-4-git-send-email-wsa@the-dreams.de>
References: <1373471889-18107-1-git-send-email-wsa@the-dreams.de>
 <1373471889-18107-4-git-send-email-wsa@the-dreams.de>
Message-ID: <CAGsJ_4ygnSs_MLHOsoOo5VK=dLL4m0-o-mFR21oKwZ=LY35jXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/7/10 Wolfram Sang <wsa@the-dreams.de>:
> Since commit ab78029 (drivers/pinctrl: grab default handles from device core),
> we can rely on device core for setting the default pins. Compile tested only.
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org> (personally at LCE13)
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>  drivers/mmc/host/mvsdio.c          |    6 ------
>  drivers/mmc/host/mxs-mmc.c         |    8 --------
>  drivers/mmc/host/omap_hsmmc.c      |    7 -------
>  drivers/mmc/host/sdhci-esdhc-imx.c |    8 --------
>  drivers/mmc/host/sdhci-sirf.c      |    8 --------

Wolfram, this has been done for sirf, which version are you based on?

>  5 files changed, 37 deletions(-)

-barry
