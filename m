From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 25 Apr 2012 08:25:18 +0200
Subject: [GIT PULL] i.MX cleanup patches for next
In-Reply-To: <20120416080053.GQ3852@pengutronix.de>
References: <20120411084403.GN3852@pengutronix.de>
 <CAOesGMhk9tGokNwy1kdFDB+G08OYEEq9Uf1Qu=K=T8ufick2ag@mail.gmail.com>
 <20120416080053.GQ3852@pengutronix.de>
Message-ID: <20120425062518.GW20478@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Mon, Apr 16, 2012 at 10:00:53AM +0200, Sascha Hauer wrote:
> 
> Ok, won't do this in future. I just thought it might be a good idea,
> because otherwise I end up with the same tag names in the next pull
> request.
> 
> > 
> > Branch contents otherwise looks OK, so respin and send a fresh pull
> > request and we'll merge it in.
> 
> Here it is:

Still something wrong?

Sascha

> 
> The following changes since commit dd775ae2549217d3ae09363e3edb305d0fa19928:
> 
>   Linux 3.4-rc1 (2012-03-31 16:24:09 -0700)
> 
> are available in the git repository at:
> 
>   git://git.pengutronix.de/git/imx/linux-2.6.git tags/arm-imx-cleanup
> 
> for you to fetch changes up to 33076883bc45bfdd5fa5c9bff7f012a460719aba:
> 
>   ARM: i.MX: efikamx: match machine descriptions with legacy (2012-04-16 09:54:50 +0200)
> 
> ----------------------------------------------------------------
> ARM: i.MX: misc board cleanups
> 
> ----------------------------------------------------------------
> Hector Oron (1):
>       ARM: i.MX: efikamx: match machine descriptions with legacy
> 
> Uwe Kleine-K?nig (1):
>       ARM: imx/mx21ads: remove unneeded cast
> 
>  arch/arm/mach-imx/mach-mx21ads.c      |    3 +--
>  arch/arm/mach-imx/mach-mx51_efikamx.c |    3 +--
>  arch/arm/mach-imx/mach-mx51_efikasb.c |    2 +-
>  3 files changed, 3 insertions(+), 5 deletions(-)
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
