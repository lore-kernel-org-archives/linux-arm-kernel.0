From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 May 2011 15:59:14 +0100
Subject: Updated mach-types update
In-Reply-To: <201105231652.28497.arnd@arndb.de>
References: <20110320110322.GC16646@n2100.arm.linux.org.uk>
	<BANLkTi=buKPmceOhF=SU6kkYRPxsJMn6hA@mail.gmail.com>
	<20110522091136.GC17672@n2100.arm.linux.org.uk>
	<201105231652.28497.arnd@arndb.de>
Message-ID: <20110523145914.GC14131@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 23, 2011 at 04:52:28PM +0200, Arnd Bergmann wrote:
> We discussed this in Budapest and basically agreed that we wouldn't stop
> new board numbers and board files from being added until there is
> enough infrastructure present to add new boards with the device tree
> only. I would certainly not stop anyone from adding new boards in the
> current merge window, or probably the next one.

Given my discussion with Linus over merging what's in my tree yesterday,
the indication is that Linus is _only_ going to take git trees which
remove code or "don't add tons of new lines", in other words only small
growth is acceptable.

Given that I don't see how new board files, which tend to be around the
thousand-line mark could be added, which rather makes updating mach-types
rather pointless.
