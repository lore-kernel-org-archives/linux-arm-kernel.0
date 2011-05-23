From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 May 2011 16:33:26 +0100
Subject: Updated mach-types update
In-Reply-To: <20110523151051.GB6489@sirena.org.uk>
References: <201105231652.28497.arnd@arndb.de>
	<20110523145914.GC14131@n2100.arm.linux.org.uk>
	<20110523151051.GB6489@sirena.org.uk>
Message-ID: <20110523153326.GB15153@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 23, 2011 at 04:10:51PM +0100, Mark Brown wrote:
> On Mon, May 23, 2011 at 03:59:14PM +0100, Russell King - ARM Linux wrote:
> 
> > Given my discussion with Linus over merging what's in my tree yesterday,
> > the indication is that Linus is _only_ going to take git trees which
> > remove code or "don't add tons of new lines", in other words only small
> > growth is acceptable.
> 
> Is this only for this merge window?

Let me turn this around.  Given that Linus has complained about the 60k LOC
growth of ARM at every merge window, and at this window we've been able to
achieve a net reduction of 15k LOC, what do you think the chances of adding
another 60k LOC at the next merge window are?

Don't get me wrong - 15k LOC removal is a good start, but it's just that,
a start.  It's well below what I was hoping for.
