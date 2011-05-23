From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 23 May 2011 16:10:51 +0100
Subject: Updated mach-types update
In-Reply-To: <20110523145914.GC14131@n2100.arm.linux.org.uk>
References: <201105231652.28497.arnd@arndb.de>
	<20110523145914.GC14131@n2100.arm.linux.org.uk>
Message-ID: <20110523151051.GB6489@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 23, 2011 at 03:59:14PM +0100, Russell King - ARM Linux wrote:

> Given my discussion with Linus over merging what's in my tree yesterday,
> the indication is that Linus is _only_ going to take git trees which
> remove code or "don't add tons of new lines", in other words only small
> growth is acceptable.

Is this only for this merge window?

> Given that I don't see how new board files, which tend to be around the
> thousand-line mark could be added, which rather makes updating mach-types
> rather pointless.

Having the machine type there at least helps people working with out of
tree board support to do the right thing.  We can't very well complain
about people reusing machine IDs or patching mach-types.h if it's not
possible to get updates made to the file and until device tree actually
works usably on the active ARM platforms (or there's a realistic prospect
of people contributing the code to make it do so as a condition for
getting their work in) it seems better to permit updates and allow
people to follow the current best practices even if we're not letting
them merge the code itself.
