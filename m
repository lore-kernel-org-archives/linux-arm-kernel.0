From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 17 Dec 2012 21:48:50 +0100
Subject: [PATCH] ARM: mx27: Replace clk_register_clkdev with clock DT
 lookup
In-Reply-To: <CAOMZO5DZv3Xi-0hHpW=eU1GHZgEsNcsDzJh9Y+=-McbN7Vb=Lg@mail.gmail.com>
References: <1354125330-18872-1-git-send-email-festevam@gmail.com>
 <CAOMZO5DZv3Xi-0hHpW=eU1GHZgEsNcsDzJh9Y+=-McbN7Vb=Lg@mail.gmail.com>
Message-ID: <20121217204850.GT26326@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 17, 2012 at 01:12:22PM -0200, Fabio Estevam wrote:
> Hi Sascha,
> 
> On Wed, Nov 28, 2012 at 3:55 PM, Fabio Estevam <festevam@gmail.com> wrote:
> > From: Fabio Estevam <fabio.estevam@freescale.com>
> >
> > Similarly as it was done for mx6q, use a DT lookup in order to make maintainance
> > task for the clock devices easier.
> >
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Does this one look good?

Looks good from a first glance, but I want to give it some testing
before I apply it.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
