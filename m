From: r.schwebel@pengutronix.de (Robert Schwebel)
Date: Wed, 18 Mar 2015 10:29:42 +0100
Subject: [PATCH] ARM: vexpress: Add unified-cache Device Tree property
In-Reply-To: <5509437E.6060806@arm.com>
References: <1426617084-1583-1-git-send-email-r.schwebel@pengutronix.de>
 <5509437E.6060806@arm.com>
Message-ID: <20150318092942.GQ8272@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 18, 2015 at 09:21:02AM +0000, Sudeep Holla wrote:
> On 17/03/15 18:31, Robert Schwebel wrote:
> >Without this propergy, we get this boot warning:
> >
>              ^^property

Uh, sorry, will fix.

> >"L2C: device tree omits to specify unified cache"
> >
> >Signed-off-by: Robert Schwebel <r.schwebel@pengutronix.de>
> 
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>

Thanks.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
