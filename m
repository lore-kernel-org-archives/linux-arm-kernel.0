From: daniel@caiaq.de (Daniel Mack)
Date: Mon, 31 May 2010 15:25:05 +0200
Subject: pxa-devel back-merge / cherry pick request
In-Reply-To: <20100531132233.GC14195@sirena.org.uk>
References: <20100531114815.GF2695@buzzloop.caiaq.de>
	<20100531124750.GA21679@n2100.arm.linux.org.uk>
	<20100531131317.GF2698@buzzloop.caiaq.de>
	<20100531132233.GC14195@sirena.org.uk>
Message-ID: <20100531132505.GI2695@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 31, 2010 at 02:22:34PM +0100, Mark Brown wrote:
> On Mon, May 31, 2010 at 03:13:17PM +0200, Daniel Mack wrote:
> 
> > Just out of interest - why would cherry-picking be frowned upon?
> > Shouldn't git just ignore the commits it already knows when things are
> > pulled?
> 
> No, git is content based.  The merge should be a noop merge if the two
> sides end up being the same but you still end up with two different
> copies of the change in history.

Ah, the commit won't have the same ID anymore after it is cherry-picked,
of course.

That makes sense. Thanks for explaining.

Daniel
