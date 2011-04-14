From: tony@atomide.com (Tony Lindgren)
Date: Thu, 14 Apr 2011 15:31:27 +0300
Subject: Status of arch/arm in linux-next
In-Reply-To: <20110414120209.GG1611@n2100.arm.linux.org.uk>
References: <20110414094447.GA1611@n2100.arm.linux.org.uk>
	<20110414110854.GF29938@atomide.com>
	<20110414120209.GG1611@n2100.arm.linux.org.uk>
Message-ID: <20110414123126.GA3336@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110414 14:59]:
> On Thu, Apr 14, 2011 at 02:08:54PM +0300, Tony Lindgren wrote:
> > 
> > It's going to take some time before the consolidated code starts
> > being available.. And until we have something available, we all
> > should aim for negative diffstat.
> 
> I think we've already lost any hope of a negative diffstat - with 6k new
> lines, we will need a heck of a lot of consolidation to counter that.
> 
> The only thing which I've seen any work being put into is some of the
> GPIO code - which will be lost in the noise in much the same way that
> my ARM platform consolidation and deletion of two machine classes in
> the last merge window was.  That resulted in the deletion of around 10k
> lines from the kernel as a whole, or 4.5k lines from arch/arm.
> 
> Some people are believing that Linus' complaint is about the core ARM
> code rather than the platform specific code which is the problem.

I think that 6k lines of new code should wait in the platform specific
trees and not get merged until we have some real progress on the
consolidation of code.
 
> We need significant amounts of effort to reverse this - and the more new
> stuff that appears in peoples trees (and therefore linux-next) the bigger
> problem we have to convince Linus that we're taking him seriously.
> 
> So, I think we've already lost any hope of making Linus happy for the
> next merge window.  I wish I'm wrong on that, but I don't think so.

We should make it clear that we're not merging new code except for code
consolidation. Looks like some people have missed it despite the
massive flaming.

Regards,

Tony
