From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 18 Mar 2013 22:06:35 +0800
Subject: [PATCH] ARM: video: mxs: Fix mxsfb misconfiguring VDCTRL0
In-Reply-To: <201303181458.17656.marex@denx.de>
References: <CAOMZO5CDuODRrJEEaDKm5nepfkuvuF77ZQmarB69hL6gg386ww@mail.gmail.com>
 <51471293.5070105@freescale.com>
 <20130318130108.GE12462@S2101-09.ap.freescale.net>
 <201303181458.17656.marex@denx.de>
Message-ID: <20130318140633.GF12462@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 18, 2013 at 02:58:17PM +0100, Marek Vasut wrote:
> Dear Shawn Guo,
> 
> > On Mon, Mar 18, 2013 at 10:11:47AM -0300, Fabio Estevam wrote:
> > > Shawn Guo wrote:
> > > > Since it touches mach-mxs as well, let me send it through arm-soc tree
> > > > as fix for 3.9.
> > > 
> > > Please CC stable as well, so that we can have X11 functional with 3.8.
> > 
> > Ok, done.
> 
> Shawn, I think this patch applies to 3.9-rc but there's one more platform in 
> mach-mxs.c in 3.9-rc thus this will have compile issue. Just renaming those two 
> FB_SYNC_ values to MXSFB_SYNC_ fixes the compile issue on 3.9-rc.

Yes, I noticed that and fixed it when applying the patch.

> Also the 
> commit log doesn't look all that cool .... I probably should have marked the 
> patch as RFC.
> 
> Shall I send you one for 3.9-rc and one for stable maybe ?

Yeah, improved patch is welcomed.  So I'm dropping the current one and
waiting for the new one.

Shawn
