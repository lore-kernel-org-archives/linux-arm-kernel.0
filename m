From: yuantian.tang@nxp.com (Y.T. Tang)
Date: Thu, 16 Feb 2017 02:21:09 +0000
Subject: [PATCH 2/2] clk: qoriq: Separate root input clock for core PLLs
 on ls1012a
In-Reply-To: <1487183790.5636.13.camel@buserror.net>
References: <1487137656-4006-1-git-send-email-yuantian.tang@nxp.com>
 <1487137656-4006-2-git-send-email-yuantian.tang@nxp.com>
 <1487183790.5636.13.camel@buserror.net>
Message-ID: <DB6PR0402MB28374AECE0955BECE2C184E5F05A0@DB6PR0402MB2837.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: Scott Wood [mailto:oss at buserror.net]
> Sent: Thursday, February 16, 2017 2:37 AM
> To: Y.T. Tang <yuantian.tang@nxp.com>; mturquette at baylibre.com
> Cc: sboyd at codeaurora.org; robh+dt at kernel.org; mark.rutland at arm.com;
> linux-clk at vger.kernel.org; devicetree at vger.kernel.org; linux-
> kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 2/2] clk: qoriq: Separate root input clock for core PLLs on
> ls1012a
> 
> On Wed, 2017-02-15 at 13:47 +0800, yuantian.tang at nxp.com wrote:
> > From: Tang Yuantian <Yuantian.Tang@nxp.com>
> >
> > ls1012a has separate input root clocks for core PLLs versus the
> > platform PLL, with the latter described as sysclk in the hw docs.
> > If a second input clock, named "coreclk", is present, this clock will
> > be used for the core PLLs.
> >
> > Signed-off-by: Scott Wood <oss@buserror.net>
> > Signed-off-by: Tang Yuantian <yuantian.tang@nxp.com>
> > ---
> > ?drivers/clk/clk-qoriq.c | 91
> > +++++++++++++++++++++++++++++++++++++++++-----
> 
> Why did you reset the author on these patches? ?Have you changed anything?
> ?Why aren't they marked either v2 or resend?
> 

I should have marked as v2 or resend. If anything changed, I take it over and dropped the 2/3 patch in your original patch set to speed up the merge, which I think so.
This patch set blocks other patches and 20 days passed, no any action on it. We can't account on you to push it. That's why I take it over and resend it.

All in all, what you suggest to do to make them get accepted ASAP?

Regards,
Yuantian
> -Scott
