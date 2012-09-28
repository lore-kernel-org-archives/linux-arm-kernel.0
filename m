From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 28 Sep 2012 14:15:30 +0100
Subject: [GIT PULL] ARM: cache flushing LoUIS API v2
In-Reply-To: <20120928131254.GB30058@e102568-lin.cambridge.arm.com>
References: <20120928092123.GA28967@e102568-lin.cambridge.arm.com>
 <20120928125446.GF7916@n2100.arm.linux.org.uk>
 <20120928131254.GB30058@e102568-lin.cambridge.arm.com>
Message-ID: <20120928131530.GG7916@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 28, 2012 at 02:12:54PM +0100, Lorenzo Pieralisi wrote:
> Ok, understood, sorry. What's the best way forward then ?
> 
> Should I add the fix for xscale and feroceon to your patch system ?

That's one solution, and probably the best as it means less commits in
the end.

Another solution is that I assume all changes I receive are bad, and
delay publishing my tree until the overnight tests have run, which adds
something like another 24 hours (or more) to the linux-next latency for
changes committed to my tree.
