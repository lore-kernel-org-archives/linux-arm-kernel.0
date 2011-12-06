From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Tue, 6 Dec 2011 03:42:11 +0000
Subject: [RFC PATCH 2/3] pinctrl: imx: add pinmux-imx53 support
In-Reply-To: <CACRpkdZ0aNj-BsdtD2R-bEWQfMzsOMNbdh6ryVtgwET3Ry7xXA@mail.gmail.com>
References: <1322999384-7886-1-git-send-email-b29396@freescale.com>
 <1322999384-7886-2-git-send-email-b29396@freescale.com>
 <20111204161123.GS27267@pengutronix.de>
 <CACRpkdZ0aNj-BsdtD2R-bEWQfMzsOMNbdh6ryVtgwET3Ry7xXA@mail.gmail.com>
Message-ID: <65EE16ACC360FA4D99C96DC085B3F7723457FD@039-SN1MPN1-002.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Linus Walleij [mailto:linus.walleij at linaro.org]
> Sent: Tuesday, December 06, 2011 1:01 AM
> To: Sascha Hauer
> Cc: Dong Aisheng-B29396; linux-kernel at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linus.walleij at stericsson.com; Guo Shawn-
> R65073; kernel at pengutronix.de
> Subject: Re: [RFC PATCH 2/3] pinctrl: imx: add pinmux-imx53 support
> 
> On Sun, Dec 4, 2011 at 5:11 PM, Sascha Hauer <s.hauer@pengutronix.de>
> wrote:
> 
> > I don't think that this grouping of pads to their functions makes
> > sense. On i.MX every pad is muxed independently and not in groups.
> > Which pins belong to which function is board specific and not SoC
> > specific.
> 
> True, Dong can this be moved to the imx pinctrl platform data and passed
> in from arch/arm/[plat|mach]-* board files instead?
> That is probably where it belongs today.
> 
Yes, I will do that.

> I know that this data is in drivers/pinctrl for the U300 and SIRF, but
> that is because they only have one single board variant.
> 
> Yours,
> Linus Walleij

Regards
Dong Aisheng
