From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 19 Feb 2013 20:06:35 +0100
Subject: [PATCH 2/9] USB: move bulk of otg/otg.c to phy/phy.c
In-Reply-To: <20130219093019.GG23197@arwen.pp.htv.fi>
References: <1359984275-24646-1-git-send-email-s.hauer@pengutronix.de>
 <1359984275-24646-3-git-send-email-s.hauer@pengutronix.de>
 <20130219093019.GG23197@arwen.pp.htv.fi>
Message-ID: <20130219190635.GB1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 19, 2013 at 11:30:19AM +0200, Felipe Balbi wrote:
> On Mon, Feb 04, 2013 at 02:24:28PM +0100, Sascha Hauer wrote:
> > Most of otg/otg.c is not otg specific, but phy specific, so move it
> > to the phy directory.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > Reported-by: Kishon Vijay Abraham I <kishon@ti.com>
> > Cc: Felipe Balbi <balbi@ti.com>
> 
> this is pretty ok, I'll start queueing patches for v3.10 in about a week
> or two.

Ok, thanks. I'll resend this after the merge window.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
