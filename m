From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 27 Aug 2013 10:49:04 -0400
Subject: [PATCH v3 0/5] Armada XP clocks for timer
In-Reply-To: <20130827085242.GB2286@localhost>
References: <1377013554-23389-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130827085242.GB2286@localhost>
Message-ID: <20130827144904.GD19598@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 27, 2013 at 05:52:43AM -0300, Ezequiel Garcia wrote:
> Hi Jason and Daniel:
> 
> (I forgot to Cc Daniel on these series, sorry about that!)
> 
> So, now that we have all the acks we need...
> 
> On Tue, Aug 20, 2013 at 12:45:49PM -0300, Ezequiel Garcia wrote:
> [...]
> > 
> > Ezequiel Garcia (5):
> >   ARM: mvebu: Add the reference 25 MHz fixed-clock to Armada XP
> >   ARM: mvebu: Add clock properties to Armada XP timer node
> 
> Jason: I assume these are ready to get merged through mvebu, right?

Yep.

> >   clocksource: armada-370-xp: Replace WARN_ON with BUG_ON
> >   clocksource: armada-370-xp: Get reference fixed-clock by name
> >   clocksource: armada-370-xp: Add detailed clock requirements in
> >     devicetree binding
> > 
> 
> Daniel: Will you pick these?

For these three:

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
