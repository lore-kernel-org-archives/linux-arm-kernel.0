From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 24 Feb 2014 10:32:29 +0100
Subject: [RFC PATCH 2/2] ARM: imx6q: Mark VPU and IPU AXI transfers as
 cacheable, increase IPU priority
In-Reply-To: <20140224020306.GA25011@S2101-09.ap.freescale.net>
References: <1392896673-13627-1-git-send-email-p.zabel@pengutronix.de>
 <1392896673-13627-2-git-send-email-p.zabel@pengutronix.de>
 <20140221021947.GR3010@S2101-09.ap.freescale.net>
 <1392978496.3091.9.camel@pizza.hi.pengutronix.de>
 <20140224020306.GA25011@S2101-09.ap.freescale.net>
Message-ID: <1393234349.3091.5.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 24.02.2014, 10:03 +0800 schrieb Shawn Guo:
> On Fri, Feb 21, 2014 at 11:28:16AM +0100, Philipp Zabel wrote:
> > Hi Shawn,
> > 
> > Am Freitag, den 21.02.2014, 10:19 +0800 schrieb Shawn Guo:
> > > On Thu, Feb 20, 2014 at 12:44:33PM +0100, Philipp Zabel wrote:
> > > > This is needed so that the IPU framebuffer scanout cannot be
> > > > starved by VPU or GPU activity.
> > > > Some boards like the SabreLite and SabreSD seem to set this in
> > > > the DCD already, but the documented register reset values do not
> > > > contain the necessary settings.
> > > > 
> > > > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > > 
> > > I'm fine with the patches, but not sure if I should just apply them
> > > since you add 'RFC' tag in there.
> > 
> > I'm not sure whether this specific fixed QoS configuration should be
> > imposed on everyone. OTOH, following the principle of least surprise,
> > it's probably better to have this here, out in the open, than included
> > hidden in bootloader DCD tables (or not, depending on the board).
> > So if nobody objects, feel free to apply them.
> 
> Okay.  But can you please fix those unnecessary line-over-80-columns
> warnings?

Ok, resent without RFC and with short lines.

regards
Philipp
