From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Wed, 7 Dec 2011 09:18:36 +0000
Subject: [RFC PATCH 3/3] pinctrl: imx: add pinmux-imx6q support
In-Reply-To: <CACRpkdbVXkpVHqhP2SHV2fud66NYFj0mcAPyaqJoyUS-20to5Q@mail.gmail.com>
References: <1322999384-7886-1-git-send-email-b29396@freescale.com>
 <1322999384-7886-3-git-send-email-b29396@freescale.com>
 <20111206072326.GA3712@S2100-06.ap.freescale.net>
 <65EE16ACC360FA4D99C96DC085B3F772345A0B@039-SN1MPN1-002.039d.mgd.msft.net>
 <CACRpkdbVXkpVHqhP2SHV2fud66NYFj0mcAPyaqJoyUS-20to5Q@mail.gmail.com>
Message-ID: <65EE16ACC360FA4D99C96DC085B3F77234FC5B@039-SN1MPN1-002.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Linus Walleij [mailto:linus.walleij at linaro.org]
> Sent: Wednesday, December 07, 2011 5:10 PM
> To: Dong Aisheng-B29396; Guo Shawn-R65073
> Cc: linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> linus.walleij at stericsson.com; s.hauer at pengutronix.de;
> kernel at pengutronix.de
> Subject: Re: [RFC PATCH 3/3] pinctrl: imx: add pinmux-imx6q support
> 
> On Tue, Dec 6, 2011 at 8:23 AM, Dong Aisheng-B29396 <B29396@freescale.com>
> wrote:
> >> From: Guo Shawn-R65073
> >> As I do not see the device tree probing added in pinmux-imx-core.c, I
> >> expect the patch has not got the chance to run on imx6, right?
> >>
> > Yes, I would add it if the pinctrl framework supports DT.
> 
> There are many levels of DT.
> 
> You can of course add DT-support for anything driver-specific, such as
> init data for some registers, or anything else you would normally pass in
> through platform data. So please just do that if imx6 already has support
> for such things.
> 
> What we're discussing about right now on devicetree-discuss is where to
> put the mapping tables etc that is currently registered by the board,
> that has no obvious solution as there is some disagreement on how to do
> that.
> 
Yes, thanks for your info.
I'm new to device tree and may take some time to get more familiar with it.

I discussed with Shawn today and now we're going to move data to dt and run
this driver on mx6q first.

Regards
Dong Aisheng
