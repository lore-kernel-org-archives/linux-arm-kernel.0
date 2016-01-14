From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 13 Jan 2016 16:29:00 -0800
Subject: [PATCH] mtd: nuc900_nand: read correct SMISR register
In-Reply-To: <5830403.0pR8UVXPRZ@wuerfel>
References: <9019174.GYajdpGP8V@wuerfel> <20160113215013.GS109450@google.com>
 <5830403.0pR8UVXPRZ@wuerfel>
Message-ID: <20160114002900.GA54220@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 13, 2016 at 11:02:06PM +0100, Arnd Bergmann wrote:
> On Wednesday 13 January 2016 13:50:13 Brian Norris wrote:
> > 
> > Looks OK to me, though I kinda hate dragging on support for
> > obviously-unused drivers...
> 
> Should we mark that driver in Kconfig as obviously broken then?

Well, it won't be obviously broken if I apply your patch... But if
that's the right step toward removal, then I could be OK with that.

> Let's wait for Wan ZongShun to reply first, it's possible that the
> entire w90x900 platform has come to the point where we are better off
> removing it than fixing ancient bugs.

Sounds good.

Brian
