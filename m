From: R65037@freescale.com (Zhu Richard-R65037)
Date: Tue, 1 Mar 2011 01:25:05 +0000
Subject: [PATCH V3 3/4] mmc: sdhci-esdhc: remove
	SDHCI_QUIRK_NO_CARD_NO_RESET from ESDHC_DEFAULT_QUIRKS
In-Reply-To: <20110228142037.GE15532@pengutronix.de>
References: <1298892725-23672-1-git-send-email-Hong-Xing.Zhu@freescale.com>
	<1298892725-23672-3-git-send-email-Hong-Xing.Zhu@freescale.com>
	<20110228142037.GE15532@pengutronix.de>
Message-ID: <010C9052C42A00499CE76D637FA5EE900C7B55@039-SN1MPN1-001.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram:
Thanks for you to make tests on your mx35 platform.

Best Regards
Richard Zhu


> -----Original Message-----
> From: Wolfram Sang [mailto:w.sang at pengutronix.de]
> Sent: Monday, February 28, 2011 10:21 PM
> To: Zhu Richard-R65037
> Cc: linux-arm-kernel at lists.infradead.org; kernel at pengutronix.de; linux-
> mmc at vger.kernel.org; cjb at laptop.org; avorontsov at ru.mvista.com;
> eric at eukrea.com; linuxzsc at gmail.com; Zhao Richard-B20223;
> Freescale at lists.linaro.org; eric.miao at linaro.org
> Subject: Re: [PATCH V3 3/4] mmc: sdhci-esdhc: remove
> SDHCI_QUIRK_NO_CARD_NO_RESET from ESDHC_DEFAULT_QUIRKS
>
> On Mon, Feb 28, 2011 at 07:32:04PM +0800, Richard Zhu wrote:
> > sdhci-esdhc-imx does not need SDHCI_QUIRK_NO_CARD_NO_RESET. Make it OF-
> specific.
> >
> > Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>
>
> Seems to work on mx35 at least:
>
> Tested-by: Wolfram Sang <w.sang@pengutronix.de>
>
> --
> Pengutronix e.K.                           | Wolfram Sang
> |
> Industrial Linux Solutions                 | http://www.pengutronix.de/
> |
