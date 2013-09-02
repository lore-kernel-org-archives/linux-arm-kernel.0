From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 2 Sep 2013 11:26:26 -0300
Subject: [PATCH v3 0/5] Armada XP clocks for timer
In-Reply-To: <20130827085242.GB2286@localhost>
References: <1377013554-23389-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130827085242.GB2286@localhost>
Message-ID: <20130902142625.GA15975@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 27, 2013 at 05:52:42AM -0300, Ezequiel Garcia wrote:
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
> 
> >   clocksource: armada-370-xp: Replace WARN_ON with BUG_ON
> >   clocksource: armada-370-xp: Get reference fixed-clock by name
> >   clocksource: armada-370-xp: Add detailed clock requirements in
> >     devicetree binding
> > 
> 
> Daniel: Will you pick these?
> 
> BTW: Is there any chance you can add your clocksource tree to linux-next?
> 
> Otherwise, our linux-next builds fail to boot whenever Jason pick some
> mvebu commits and therefore appears in linux-next, but the corresponding
> clocksource commit is taken by you and missing from linux-next.
> 

Daniel,

Any updates on this? The merge is really close now, and I'd like
to know if you're going to pick these (and where!) for v3.12.

Notice that Jason already took the devicetree patches, so unless
you merge the clocksource driver changes for v3.12, we'll have
to revert the former.

Regards,
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
