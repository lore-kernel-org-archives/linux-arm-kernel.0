From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 26 Sep 2011 20:40:24 -0400 (EDT)
Subject: Pull request: removal of most instances of mach/memory.h
In-Reply-To: <20110926232943.GD23680@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.00.1109130849590.20358@xanadu.home>
	<alpine.LFD.2.00.1109201349400.12663@xanadu.home>
	<20110926131524.GJ22455@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1109260952490.2718@xanadu.home>
	<alpine.LFD.2.00.1109261023360.2718@xanadu.home>
	<20110926191055.GP22455@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1109261514330.2718@xanadu.home>
	<alpine.LFD.2.00.1109261606210.2718@xanadu.home>
	<20110926223839.GB23680@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1109261901550.2718@xanadu.home>
	<20110926232943.GD23680@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1109262028310.2718@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 27 Sep 2011, Russell King - ARM Linux wrote:

> On Mon, Sep 26, 2011 at 07:03:12PM -0400, Nicolas Pitre wrote:
> > On Mon, 26 Sep 2011, Russell King - ARM Linux wrote:
> > 
> > > On Mon, Sep 26, 2011 at 04:10:03PM -0400, Nicolas Pitre wrote:
> > > > On Mon, 26 Sep 2011, Nicolas Pitre wrote:
> > > > 
> > > > > On Mon, 26 Sep 2011, Russell King - ARM Linux wrote:
> > > > > 
> > > > > > This also gives additional merge conflicts elsewhere, and while git
> > > > > > rerere makes some of them easy, the quantity is going to be a right
> > > > > > pain to deal with on a repeated basis.
> > > > > 
> > > > > Again, I'm perfectly willing to use a different base for this series and 
> > > > > fix the conflicts myself if you give me one.
> > > > 
> > > > Nevermind, I see that you merged it anyway.
> > > > 
> > > > You may consider the rerere.autoupdate config option if you want Git to 
> > > > automatically pick the conflict resolution without you manually 
> > > > confirming them all the time.
> > > 
> > > rerere doesn't deal with modified/deleted conflicts though.
> > 
> > True.  That can be considered a limitation worth fixing.
> 
> Well.  Now I'm not impressed, having investigated the reason behind
> some of these conflicts.
> 
> The reason I'm getting the modify/delete conflict is because you've
> made the same change to arch/arm/mach-prima2/include/mach/memory.h
> as the one which you already submitted to me.
> 
> I've no idea why you submitted this change to me if you'd already merged
> it into your own tree - this is total madness and is just making more
> work for me with no reason.

I submitted that change to you separately via the patch system because I 
was getting no feedback from you despite two subsequent pings.  Hence 
after more than two weeks of total silence I decided to send the obvious 
pieces separately.  

Today you replied saying that the series is unacceptable because it 
contains a patch you can't test right now, even if I clearly stated that 
I could remove it in my pull request message.

Then I notice you merged both the separate patch and the modified 
request, although I had given up hope about the later.

> A little more discipline and communication (such as asking me to drop
> the duplicate commit _first_) would be nice.

Certainly.  Improving communication both ways might help.


Nicolas
