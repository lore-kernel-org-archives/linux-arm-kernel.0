From: dong.aisheng@linaro.org (Dong Aisheng)
Date: Fri, 10 Aug 2012 11:14:38 +0800
Subject: [PATCH] pinctrl: pinctrl-imx: add imx35 pinctrl driver
In-Reply-To: <1344529412-18053-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343921942-22079-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1344529412-18053-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <CAP1dx+y7hjPcCHzfL+Axjz-NK12Vq4YkU_UFcXnKhNP0_UT0vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 August 2012 00:23, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> This is mostly cut'n'paste from the imx51 pinctrl driver. The data was
> generated using sed and awk on
> arch/arm/plat-mxc/include/mach/iomux-mx35.h.
>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Acked-by: Stephen Warren <swarren@wwwdotorg.org>
> Acked-by: Dong Aisheng <dong.aisheng@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> --
> Changes since (implicit) v1,
> id:1343921942-22079-1-git-send-email-u.kleine-koenig at pengutronix.de
>
>  - remove references to file names in binding documentation
>  - remove sed commands from comments in driver
>  - add explicit numbers for pins and functions
>
> @Stephen and Dong: I assumed your ack even though we didn't talk about
> adding numbers for the functions. If you don't like these please scream
> before the patch makes it in :-)
Is that for align with the pin func ids in binding doc?
It looks no harmful, so i'm ok with it.

Regards
Dong Aisheng
