From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 14 Oct 2011 14:18:12 +0200
Subject: [PATCH 2/2] arm/mx5: add device tree support for imx51 babbage
In-Reply-To: <20111014090043.GA28416@S2100-06.ap.freescale.net>
References: <1317389747-24589-1-git-send-email-shawn.guo@linaro.org>
	<1317389747-24589-3-git-send-email-shawn.guo@linaro.org>
	<CACxGe6v-3D=QS8EfFXyZc84Gr2C+gSv+PCi-Z7rRpXQcZcb8SQ@mail.gmail.com>
	<20111014083853.GE13898@pengutronix.de>
	<20111014090043.GA28416@S2100-06.ap.freescale.net>
Message-ID: <20111014121812.GH13898@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 14, 2011 at 05:00:44PM +0800, Shawn Guo wrote:
> On Fri, Oct 14, 2011 at 10:38:53AM +0200, Sascha Hauer wrote:
> > On Thu, Oct 13, 2011 at 08:20:04PM -0600, Grant Likely wrote:
> > > On Fri, Sep 30, 2011 at 7:35 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > > > It adds device tree support for imx51 babbage board.
> > > >
> > > > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > > > Cc: Grant Likely <grant.likely@secretlab.ca>
> > > > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > > > Acked-by: Grant Likely <grant.likely@secretlab.ca>
> > > 
> > > looks good to me.
> > 
> > to me aswell.
> 
> I take this as your ack tag.  Otherwise, please let me know.

Yes, Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

> 
> > To merge it a patch from Rob Herring is missing:
> > 
> > of/irq: introduce of_irq_init
> > 
> > It currently does not show up in next.
> > 
> Rob just sent a pull request to Arnd with this patch included.  If you
> do not mind, I will send this series to Arnd based on proper branch in
> arm-soc.

ok.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
