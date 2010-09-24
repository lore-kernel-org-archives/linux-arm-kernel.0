From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 23 Sep 2010 21:27:03 -0400 (EDT)
Subject: [PATCH] ARM: abstract atags parsing
In-Reply-To: <AANLkTikwT-w_6Y+yzZ014g6tijUTUzZUAa7g=eE8F+nt@mail.gmail.com>
References: <alpine.LFD.2.00.1009231713570.13233@xanadu.home>
	<20100923213113.GC26295@n2100.arm.linux.org.uk>
	<AANLkTikwT-w_6Y+yzZ014g6tijUTUzZUAa7g=eE8F+nt@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1009232122010.13233@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 23 Sep 2010, Grant Likely wrote:

> On Thu, Sep 23, 2010 at 3:31 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Thu, Sep 23, 2010 at 05:18:02PM -0400, Nicolas Pitre wrote:
> >> This code movement will make it cleaner and easier to introduce support
> >> for device tree which is basically an alternative to atags. No functional
> >> changes are introduced by this patch.
> >
> > I don't see any point to this churn.
> 
> I can carry it in test-devicetree branch until you become okay with it.

That is probably the best course of action.  I thought this was a nice 
cleanup that could stand on its own, but if RMK doesn't want it without 
a bigger reason (e.g. full DT implementation) then it is best if you 
carry it in your repository.


Nicolas
