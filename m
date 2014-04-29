From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 29 Apr 2014 01:26:56 +0100
Subject: [PATCH 93/97] ARM: l2c: convert mvebu to generic l2c
 initialisation
In-Reply-To: <20140429002132.GD28159@titan.lakedaemon.net>
References: <20140428192419.GV26756@n2100.arm.linux.org.uk>
 <E1WerJX-0001a0-6K@rmk-PC.arm.linux.org.uk>
 <20140429002132.GD28159@titan.lakedaemon.net>
Message-ID: <20140429002656.GY26756@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 08:21:32PM -0400, Jason Cooper wrote:
> On Mon, Apr 28, 2014 at 08:34:07PM +0100, Russell King wrote:
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> >  arch/arm/mach-mvebu/board-v7.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> Are you taking this, or shall I?  We already have one trivial conflict
> with your UL patch.  This won't be any worse than that, so
> 
> Acked-by: Jason Cooper <jason@lakedaemon.net>
> 
> Otherwise, just let me know and I'll pick it up.

Neither, I've just decided to scrap the entire lot of patches.  I don't
care whether people think this set was a good idea or not, it's just
impractical to merge this kind of change with people who can't be fucked
to look at the earlier series, and then come around wanting patches
split up and other crap like that, and who make accusations about patches
not being acked.

I've had enough of crap like this.

Core ARM maintanence is impossible.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
