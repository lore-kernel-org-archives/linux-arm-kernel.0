From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 2 Apr 2013 15:59:19 +0200
Subject: [PATCH] ARM: imx1: mm: add call to mxc_device_init
In-Reply-To: <20130402131630.GE27148@S2101-09.ap.freescale.net>
References: <1363448999-3936-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
 <20130325140940.GH1906@pengutronix.de>
 <20130402131630.GE27148@S2101-09.ap.freescale.net>
Message-ID: <20130402135919.GO1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 02, 2013 at 09:16:33PM +0800, Shawn Guo wrote:
> Sascha,
> 
> On Mon, Mar 25, 2013 at 03:09:40PM +0100, Sascha Hauer wrote:
> > On Sat, Mar 16, 2013 at 04:49:59PM +0100, Gwenhael Goavec-Merou wrote:
> > > mxc_device_init() is mandatory for mxc_aips and mxc_ahb bus registration, needed 
> > > as parents, at least, for gpio and dma.
> > > 
> > > Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
> > 
> > Applied, thanks
> 
> I did not see this patch in those you ask me to handle.  Has it been
> handled or just missed?

I seem to have lost it, although I'm pretty sure I really applied it and
not just said so.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
