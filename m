From: marex@denx.de (Marek Vasut)
Date: Tue, 28 May 2013 06:56:27 +0200
Subject: [PATCH 1/3] ARM: dts: imx28-evk: Enable touchscreen support
In-Reply-To: <20130528014348.GA19608@S2101-09.ap.freescale.net>
References: <1360337803-19858-1-git-send-email-festevam@gmail.com>
 <CAOMZO5DRuKrECnYDtZ0wOK6_vpW95Cwc3xf7LT+VT_B7eV3gug@mail.gmail.com>
 <20130528014348.GA19608@S2101-09.ap.freescale.net>
Message-ID: <201305280656.27472.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> On Mon, May 27, 2013 at 09:52:21PM -0300, Fabio Estevam wrote:
> > Hi Shawn,
> > 
> > On Mon, May 13, 2013 at 11:31 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > > Have you tested it against v3.10-rc1?  The issue is still there in my
> > > testing.
> > 
> > I am not able to see the issue on 3.10-rc2.
> 
> My imx/dt branch is currently basing on v3.10-rc1, and I do not care if
> it works on v3.10-rc2.  I have tested this patch enough on different
> bases, and I'm not going to test it again and again to find a base which
> happens to work.  I do not feel comfortable to merge this patch if it
> only works on particular base.  Who knows if it will break again with
> another random patches merged in.  There is some issue, and we need to
> find the root cause of it instead of ignoring it by finding some random
> base which hides it.
> 
> > What are the exact steps to trigger the problem? Do you see it
> > consistently?
> 
> Before I answer your questions, can I ask if you have tried to reproduce
> it on v3.10-rc1?

What is the problem you observe?

Best regards,
Marek Vasut
