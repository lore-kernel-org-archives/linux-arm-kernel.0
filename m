From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 8 Jul 2010 09:42:42 +0200
Subject: [PATCH] [arm l2x0] Extend cache-l2x0 to support the
	16-wayPL310 (v3)
In-Reply-To: <1278521560.22992.50.camel@e102109-lin.cambridge.arm.com>
References: <1272985254-5675-1-git-send-email-jason.mcmullan@netronome.com>
	<1272985254-5675-2-git-send-email-jason.mcmullan@netronome.com>
	<20100706065907.GH26079@pengutronix.de>
	<1278521560.22992.50.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20100708074241.GY26079@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 07, 2010 at 05:52:40PM +0100, Catalin Marinas wrote:
> On Tue, 2010-07-06 at 07:59 +0100, Sascha Hauer wrote:
> > commit 7cb529f07fb864816d56000374b2b4aeccba00f0
> > Author: Sascha Hauer <s.hauer@pengutronix.de>
> > Date:   Tue Jul 6 08:53:55 2010 +0200
> > 
> >     [arm l2x0] Do not rely on reset defaults of L2X0_AUX_CTRL
> >    
> >     On i.MX35 the L2X0_AUX_CTRL register does not have sensible reset
> >     default values. Allow them to be overwritten with the aux_val/aux_mask
> >     arguments passed to l2x0_init().
> >    
> >     Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Ok, I put it in the patch system as 6210/1

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
