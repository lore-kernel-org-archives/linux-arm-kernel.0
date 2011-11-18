From: r.schwebel@pengutronix.de (Robert Schwebel)
Date: Fri, 18 Nov 2011 23:35:10 +0100
Subject: [PATCH] MEM2MEM: Add support for eMMa-PrP mem2mem operations.
In-Reply-To: <CACKLOr0spqXzYZUPcDkDxCqZXkCM+F6crEQ3R0VbS-HGvZADtA@mail.gmail.com>
References: <1321460614-2108-1-git-send-email-javier.martin@vista-silicon.com>
 <4EC682B8.10300@gmail.com>
 <CACKLOr0spqXzYZUPcDkDxCqZXkCM+F6crEQ3R0VbS-HGvZADtA@mail.gmail.com>
Message-ID: <20111118223510.GN12903@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 18, 2011 at 05:27:12PM +0100, javier Martin wrote:
> But yes, it could be possible. AFAIK, Sascha Hauer (added to CC) has a
> prototype driver for this one though.

Yes, we have indeed a prototype for the VPU, both on MX27 and MX53.
However, it wasn't changed to a mem2mem device yet, although that is
what needs to be done. Unfortunately, we currently do not have a
customer who would let us drive that forward, so it probably needs some
time until we find somebody and can work on that again.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
