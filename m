From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 14 Oct 2011 10:38:53 +0200
Subject: [PATCH 2/2] arm/mx5: add device tree support for imx51 babbage
In-Reply-To: <CACxGe6v-3D=QS8EfFXyZc84Gr2C+gSv+PCi-Z7rRpXQcZcb8SQ@mail.gmail.com>
References: <1317389747-24589-1-git-send-email-shawn.guo@linaro.org>
	<1317389747-24589-3-git-send-email-shawn.guo@linaro.org>
	<CACxGe6v-3D=QS8EfFXyZc84Gr2C+gSv+PCi-Z7rRpXQcZcb8SQ@mail.gmail.com>
Message-ID: <20111014083853.GE13898@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 13, 2011 at 08:20:04PM -0600, Grant Likely wrote:
> On Fri, Sep 30, 2011 at 7:35 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > It adds device tree support for imx51 babbage board.
> >
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > Acked-by: Grant Likely <grant.likely@secretlab.ca>
> 
> looks good to me.

to me aswell. To merge it a patch from Rob Herring is missing:

of/irq: introduce of_irq_init

It currently does not show up in next.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
