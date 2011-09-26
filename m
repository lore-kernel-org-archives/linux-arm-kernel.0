From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 26 Sep 2011 23:38:39 +0100
Subject: Pull request: removal of most instances of mach/memory.h
In-Reply-To: <alpine.LFD.2.00.1109261606210.2718@xanadu.home>
References: <alpine.LFD.2.00.1109062158450.20358@xanadu.home>
	<alpine.LFD.2.00.1109130849590.20358@xanadu.home>
	<alpine.LFD.2.00.1109201349400.12663@xanadu.home>
	<20110926131524.GJ22455@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1109260952490.2718@xanadu.home>
	<alpine.LFD.2.00.1109261023360.2718@xanadu.home>
	<20110926191055.GP22455@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1109261514330.2718@xanadu.home>
	<alpine.LFD.2.00.1109261606210.2718@xanadu.home>
Message-ID: <20110926223839.GB23680@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 26, 2011 at 04:10:03PM -0400, Nicolas Pitre wrote:
> On Mon, 26 Sep 2011, Nicolas Pitre wrote:
> 
> > On Mon, 26 Sep 2011, Russell King - ARM Linux wrote:
> > 
> > > This also gives additional merge conflicts elsewhere, and while git
> > > rerere makes some of them easy, the quantity is going to be a right
> > > pain to deal with on a repeated basis.
> > 
> > Again, I'm perfectly willing to use a different base for this series and 
> > fix the conflicts myself if you give me one.
> 
> Nevermind, I see that you merged it anyway.
> 
> You may consider the rerere.autoupdate config option if you want Git to 
> automatically pick the conflict resolution without you manually 
> confirming them all the time.

rerere doesn't deal with modified/deleted conflicts though.
