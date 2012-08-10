From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 10 Aug 2012 06:45:44 +0200
Subject: [PATCH] pinctrl: pinctrl-imx: add imx35 pinctrl driver
In-Reply-To: <CAP1dx+y7hjPcCHzfL+Axjz-NK12Vq4YkU_UFcXnKhNP0_UT0vw@mail.gmail.com>
References: <1343921942-22079-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1344529412-18053-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CAP1dx+y7hjPcCHzfL+Axjz-NK12Vq4YkU_UFcXnKhNP0_UT0vw@mail.gmail.com>
Message-ID: <20120810044544.GH25520@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Aug 10, 2012 at 11:14:38AM +0800, Dong Aisheng wrote:
> On 10 August 2012 00:23, Uwe Kleine-K?nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > This is mostly cut'n'paste from the imx51 pinctrl driver. The data was
> > generated using sed and awk on
> > arch/arm/plat-mxc/include/mach/iomux-mx35.h.
> >
> > Cc: Shawn Guo <shawn.guo@linaro.org>
> > Acked-by: Stephen Warren <swarren@wwwdotorg.org>
> > Acked-by: Dong Aisheng <dong.aisheng@linaro.org>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > --
> > Changes since (implicit) v1,
> > id:1343921942-22079-1-git-send-email-u.kleine-koenig at pengutronix.de
> >
> >  - remove references to file names in binding documentation
> >  - remove sed commands from comments in driver
> >  - add explicit numbers for pins and functions
> >
> > @Stephen and Dong: I assumed your ack even though we didn't talk about
> > adding numbers for the functions. If you don't like these please scream
> > before the patch makes it in :-)
> Is that for align with the pin func ids in binding doc?
> It looks no harmful, so i'm ok with it.
Yeah, the idea was to make the (more important) mapping also explicit in
the driver to allow for grepping there.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
