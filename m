From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 2 Aug 2013 14:27:07 +0100
Subject: select statement sort order in arch/arm/Kconfig -- again
In-Reply-To: <20130802131850.GY5882@titan.lakedaemon.net>
References: <20130801170812.GA23006@n2100.arm.linux.org.uk>
 <20130802131850.GY5882@titan.lakedaemon.net>
Message-ID: <20130802132707.GP23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 02, 2013 at 09:18:50AM -0400, Jason Cooper wrote:
> On Thu, Aug 01, 2013 at 06:08:12PM +0100, Russell King - ARM Linux wrote:
> > So, we go one kernel release since I fixed the ordering in this file
> > after Andrew Morton's complaint about conflicts, and people manage to
> > mess up the ordering.  Sorting the stuff in this file is clearly a
> > waste of time.
> > 
> > Not impressed.
> > 
> > On the plus side, I have a script which sorts these, so it's not
> > difficult to put them back into the correct order - that's not the
> > point - I _shouldn't_ have to do this.  It's just that it's _EXTRA_
> > _UNNECESSARY_ _CHURN_ each time I have to clean up after the fact.
> 
> iirc, you had to update the script since you posted it the last time.
> Would you mind posting it again?

If you're talking about the version in message
	20121012144832.GN28061 at n2100.arm.linux.org.uk

then that's the version I re-ran.  It hasn't changed since then.
