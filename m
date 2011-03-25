From: R65037@freescale.com (Zhu Richard-R65037)
Date: Fri, 25 Mar 2011 09:05:51 +0000
Subject: [PATCH V8 3/4] mmc: sdhci-esdhc: make the writel/readl as the
	general APIs
In-Reply-To: <20110325085329.GA3302@pengutronix.de>
References: <1301024346-2232-1-git-send-email-Hong-Xing.Zhu@freescale.com>
	<1301024346-2232-3-git-send-email-Hong-Xing.Zhu@freescale.com>
	<20110325085329.GA3302@pengutronix.de>
Message-ID: <010C9052C42A00499CE76D637FA5EE900D45DB@039-SN1MPN1-001.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram:
Got that.
Thanks for your reminder.
Would follow your advice in future.

Best Regards
Richard Zhu

> -----Original Message-----
> From: Wolfram Sang [mailto:w.sang at pengutronix.de]
> Sent: Friday, March 25, 2011 4:53 PM
> To: Zhu Richard-R65037
> Cc: linux-arm-kernel at lists.infradead.org; kernel at pengutronix.de; linux-
> mmc at vger.kernel.org; cjb at laptop.org; avorontsov at ru.mvista.com;
> eric at eukrea.com; linuxzsc at gmail.com; eric.miao at linaro.org
> Subject: Re: [PATCH V8 3/4] mmc: sdhci-esdhc: make the writel/readl as
> the general APIs
>
> On Fri, Mar 25, 2011 at 11:39:05AM +0800, Richard Zhu wrote:
> > Add one flag to indicate the GPIO CD/WP is enabled or not on imx
> > platforms, and reuse the writel/readl as the general APIs for imx
> > SOCs.
> >
> > Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>
> > ---
>
> Please provide something like "changes since last time" _below_ this
> dashed line "---" next time. Or use --cover-letter to introduce the
> changes.
>
> Other than that
>
> Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>
>
> Regards,
>
>    Wolfram
>
> --
> Pengutronix e.K.                           | Wolfram Sang
> |
> Industrial Linux Solutions                 | http://www.pengutronix.de/
> |
