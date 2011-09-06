From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 6 Sep 2011 21:25:47 +0800
Subject: [PATCH] ARM: mxs: Add initial support for DENX MX28
In-Reply-To: <20069.58232.365025.824697@ipc1.ka-ro>
References: <1314604250-29511-1-git-send-email-sbabic@denx.de>
	<20110906083926.GE28816@pengutronix.de>
	<20069.58232.365025.824697@ipc1.ka-ro>
Message-ID: <20110906132546.GC7651@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 06, 2011 at 11:10:16AM +0200, Lothar Wa?mann wrote:
> Hi,
> 
> Uwe Kleine-K?nig writes:
> > Hello Stefano,
> > 
> > On Mon, Aug 29, 2011 at 09:50:50AM +0200, Stefano Babic wrote:
> > > Added initial support for DENX M28 module and M28EVK
> > > board. Ethernet(FEC), SDHC, Display are supported.
> > > 
> > > Signed-off-by: Stefano Babic <sbabic@denx.de>
> > All in all I like your patch, just a few minor issues below.
> > 
> When I tried to send a patch for new board support a few weeks ago I
> was told that no more new boards files would be added due to upcoming
> DTS support:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2011-July/057649.html
> Has this policy changed since?

No.

> Should I resend my patch for the TX53?
> 
No.

I remain my strong position on i.mx53.  And I would also suggest Sascha
not take this patch to force people to start the effort of migrating mxs
to device tree.  But comparing to the progress we have made on i.mx53,
mxs gets nothing to start with yet, and people have to start from
ground.  That said I do not have a strong position on i.mx28 as I do
on i.mx53.

-- 
Regards,
Shawn
