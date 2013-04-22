From: marex@denx.de (Marek Vasut)
Date: Tue, 23 Apr 2013 01:57:47 +0200
Subject: [RFC][PATCH] video: imx: Select VIDEOMODE_HELPERS
In-Reply-To: <CAOMZO5Av8RyptoxAQ13Psxjjd4nhHVbEJoVm6SqyLr55bPmSng@mail.gmail.com>
References: <1366666110-9585-1-git-send-email-marex@denx.de>
 <CAOMZO5Av8RyptoxAQ13Psxjjd4nhHVbEJoVm6SqyLr55bPmSng@mail.gmail.com>
Message-ID: <201304230157.47992.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Fabio Estevam,

> Hi Marek,
> 
> On Mon, Apr 22, 2013 at 6:28 PM, Marek Vasut <marex@denx.de> wrote:
> > Without this, I get the following problem when building kernel:
> > 
> > drivers/built-in.o: In function `imx_pd_connector_get_modes':
> > /linux-2.6/drivers/staging/imx-drm/parallel-display.c:78: undefined
> > reference to `of_get_drm_display_mode' make: *** [vmlinux] Error 1
> > 
> > NOTE: I think this patch is almost absolutely not correct.
> > 
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Philipp Zabel <p.zabel@pengutronix.de>
> > Cc: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Patch looks good, but you should have copied Greg Kroah-Hartman, as he
> is the one who takes patches into staging.

I'm not sure if the select is at correct symbol, I dont think it is.

Best regards,
Marek Vasut
