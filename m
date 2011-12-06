From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Tue, 6 Dec 2011 07:35:12 +0000
Subject: [RFC PATCH 1/3] pinctrl: imx: add pinmux imx core driver
In-Reply-To: <20111206073908.GC3712@S2100-06.ap.freescale.net>
References: <1322999384-7886-1-git-send-email-b29396@freescale.com>
 <20111206073908.GC3712@S2100-06.ap.freescale.net>
Message-ID: <65EE16ACC360FA4D99C96DC085B3F772345A4D@039-SN1MPN1-002.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Guo Shawn-R65073
> Sent: Tuesday, December 06, 2011 3:39 PM
> To: Dong Aisheng-B29396
> Cc: linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> linus.walleij at stericsson.com; s.hauer at pengutronix.de;
> kernel at pengutronix.de
> Subject: Re: [RFC PATCH 1/3] pinctrl: imx: add pinmux imx core driver
> 
> On Sun, Dec 04, 2011 at 07:49:42PM +0800, Dong Aisheng wrote:
> > +static struct platform_device_id imx_pinctrl_devtype[] = {
> > +	{
> > +		.name = "sdhci-pinctrl-imx53",
> > +		.driver_data = (kernel_ulong_t)&mx53_pinctrl_info,
> > +	}, {
> > +		.name = "sdhci-pinctrl-imx6q",
> > +		.driver_data = (kernel_ulong_t)&mx6q_pinctrl_info,
> > +	},
> > +};
> 
> The platform_device_id table needs an empty entry to be the sentinel.
> 
Acked.

Regards
Dong Aisheng
