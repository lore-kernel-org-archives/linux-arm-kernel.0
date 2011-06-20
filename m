From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 20 Jun 2011 09:20:36 +0200
Subject: [PATCH v2 5/6] ARM: mxc: all three imx51 TOs use TO1 version of
	sdma script
In-Reply-To: <20110617022717.GE10154@S2100-06.ap.freescale.net>
References: <1307950645-26529-6-git-send-email-shawn.guo@linaro.org>
	<1308032407-3860-1-git-send-email-shawn.guo@linaro.org>
	<20110614203809.GA23771@pengutronix.de>
	<20110615042948.GB31712@S2100-06.ap.freescale.net>
	<20110616073018.GF23771@pengutronix.de>
	<20110616115112.GA9605@S2100-06.ap.freescale.net>
	<BANLkTinad=5ZwGueYGxct7iHkZ52x6LaLA@mail.gmail.com>
	<20110617022717.GE10154@S2100-06.ap.freescale.net>
Message-ID: <20110620072036.GP23771@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 17, 2011 at 10:27:18AM +0800, Shawn Guo wrote:
> On Thu, Jun 16, 2011 at 10:59:41PM -0300, Fabio Estevam wrote:
> > On Thu, Jun 16, 2011 at 8:51 AM, Shawn Guo <shawn.guo@freescale.com> wrote:
> > ...
> > > That means the sdma firmware dose not change since to1, confusing?
> > > But I'm fine with your idea, so okay, drop the patch from the series,
> > > and let's address this issue with another patch.
> > >
> > > Other patches look good to be applied?
> > 
> > The other SDMA patches you sent are already in imx-for-2.6.40 now:
> > http://git.pengutronix.de/?p=imx/linux-2.6.git;a=shortlog;h=refs/heads/imx-for-2.6.40
> > 
> Ah, thanks.  I have been keeping my eyes on branch imx-for-3.0, so
> really did not check imx-for-2.6.40.  But patch #6 which is the main
> initiative of the whole patch set is still not applied yet.  I
> suppose it will go through imx-for-3.0.
> 
> Speaking of the branch name imx-for-3.0, I'm a little confused here.
> Shouldn't it be imx-for-3.1, if it targets the next merge window?
> I'm wrong?
> 
> > I think it would be nice if Sascha could reply with a 'applied' email
> > so we know that the patches we sent were accepted.
> > 
> +1.  It would be even better with the branch info. 

+1. Wait, I am Sascha. Will do in the future.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
