From: tony@atomide.com (Tony Lindgren)
Date: Fri, 16 May 2014 14:11:25 -0700
Subject: [PATCH] ARM: OMAP: remove some dead code
In-Reply-To: <20140515194317.GB4752@drone.musicnaut.iki.fi>
References: <1400181381.11786.18.camel@x220>
 <20140515194317.GB4752@drone.musicnaut.iki.fi>
Message-ID: <20140516211125.GE12881@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [140515 12:48]:
> On Thu, May 15, 2014 at 09:16:21PM +0200, Paul Bolle wrote:
> > A check for CONFIG_CBUS_TAHVO_USB was added in v2.6.17. The related
> > Kconfig symbol has never been part of the tree. Remove that check.
> > 
> > Replace the while (...) loop with a simple if (...) statement, while
> > we're at it.
> > 
> > Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> 
> Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> 
> > ---
> > Untested, as usual.
> > 
> > A quick search across the history of the tree suggests CBUS_TAHVO_USB
> > was N770 related. Not that this matters much.
> 
> Yes, Tahvo USB is only used on Nokia 770 (which is the correct name,
> not N770). The driver is nowadays behind TAHVO_USB, but like you said
> the old symbol was never part of the mainline so it's OK to delete it.

Thanks applying into omap-for-v3.16/board.

Tony
