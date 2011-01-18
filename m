From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 18 Jan 2011 12:06:10 +0100
Subject: [PATCH] pxa3xx: fix PXA GPIO IRQ handling
In-Reply-To: <1295338738-4129-1-git-send-email-s.neumann@raumfeld.com>
References: <1295338561.2003.3.camel@sven>
	<1295338738-4129-1-git-send-email-s.neumann@raumfeld.com>
Message-ID: <20110118110610.GX6917@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 18, 2011 at 09:18:58AM +0100, Sven Neumann wrote:
> From: Lars-Peter Clausen <lars@metafoo.de>
> 
> Set the "set_wake" field of the irq_chip struct before calling
> set_irq_chip() for all of the IRQs, so that the compat handler
> actually gets installed.
> 
> Tested-by: Sven Neumann <s.neumann@raumfeld.com>
If you send the patch out it needs your S-o-b, too.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
