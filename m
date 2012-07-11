From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 11 Jul 2012 15:28:29 +0800
Subject: [PATCH] ARM: mxs: rename dts files with soc name being the prefix
In-Reply-To: <4FFD28CC.5040909@free-electrons.com>
References: <1341981977-18207-1-git-send-email-shawn.guo@linaro.org>
 <4FFD28CC.5040909@free-electrons.com>
Message-ID: <20120711072827.GG14060@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2012 at 09:18:36AM +0200, Maxime Ripard wrote:
> Hi,
> 
> Le 11/07/2012 06:46, Shawn Guo a ?crit :
> > Rename mxs dts files with soc name being the prefix, so that the board
> > dts file can be located easily by soc name, and we also gain the
> > consistency of naming.
> > 
> > Suggested-by: Marek Vasut <marex@denx.de>
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> >  .../boot/dts/{cfa10036.dts => imx23-cfa10036.dts}  |    0
> 
> It's an imx28 board
> 
Oops, sorry.  Fixed, thanks.

-- 
Regards,
Shawn
