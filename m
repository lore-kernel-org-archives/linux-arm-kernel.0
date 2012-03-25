From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 25 Mar 2012 11:05:14 -0400
Subject: [PATCH V2 1/3] ARM: kirkwood: Basic support for DNS-320 and
 DNS-325
In-Reply-To: <201203241926.00597.arnd@arndb.de>
References: <1332594876-8673-1-git-send-email-jm@lentin.co.uk>
 <1332594876-8673-2-git-send-email-jm@lentin.co.uk>
 <201203241926.00597.arnd@arndb.de>
Message-ID: <20120325150514.GP2484@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 24, 2012 at 07:26:00PM +0000, Arnd Bergmann wrote:
> On Saturday 24 March 2012, Jamie Lentin wrote:
> > 
> > Add support for the DNS-320 and DNS-325. Describe as much as currently possible
> > in the devicetree files, create a board-dnskw.c for everything else.
> > 
> > Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
> 
> Looks good to me. 

Me as well.  Jamie, if you could just incorporate the
orion_nand/kirkwood split and then resubmit (don't forget the acks),
I'll pull them in.

> Jason, do you want to add these to your tree? You are already have some
> the patches for dreamplug, and I think it makes sense to update these two
> together when you have more patches.

Will do.

> Since the dnskw board file contains mostly gpio setup, I think it would
> be good if one of you could take that part on next: once the gpio controller
> uses DT probing, you can move all the gpio leds and buttons into the
> device tree, which drastically shrinks the dnskw file.

Agreed.  Jamie, would you mind working on that while I work on the irq
controller?

Other than my one comment about the patch split, please consider this
series:

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.

> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> 	Arnd
