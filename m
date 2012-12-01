From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 1 Dec 2012 10:41:05 -0500
Subject: [PATCH] ARM: ixp4xx: Add "ask" handler for timer interrupts
In-Reply-To: <1354367688.468230210@f2.mail.ru>
References: <1354347213-22237-1-git-send-email-shc_work@mail.ru>
 <20121201130527.GD12509@titan.lakedaemon.net>
 <1354367688.468230210@f2.mail.ru>
Message-ID: <20121201154105.GE12509@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 01, 2012 at 05:14:48PM +0400, Alexander Shiyan wrote:
> > On Sat, Dec 01, 2012 at 11:33:33AM +0400, Alexander Shiyan wrote:
> > > Rather than modify the EOI flags directly in the timer interrupt,
> > > let's deal with these flags in the "ask" procedure.
> > 
> > Please specify the procedure name instead of "ask", eg ixp4xx_irq_ack().
> > Same goes for the Subject line.
> > 
> > What brought about this change, is this part of a larger series?
> 
> It all started with an attempt to clear the unneeded calls from drivers.
> Series not yet, just an initial attempt to put everything in its place.

Ok, sounds good.  There's definitely a lot of cleanup work in ixp4xx.
Drivers needing moved to drivers/, etc.

thx,

Jason.
