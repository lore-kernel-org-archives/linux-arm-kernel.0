From: broonie@kernel.org (Mark Brown)
Date: Wed, 11 Dec 2013 11:02:43 +0000
Subject: [Linaro-acpi] [RFC part1 PATCH 1/7] ACPI: Make ACPI core running
 without PCI on ARM64
In-Reply-To: <201312110407.27848.arnd@arndb.de>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org>
 <201312102100.20570.arnd@arndb.de>
 <20131210202323.GJ11468@sirena.org.uk>
 <201312110407.27848.arnd@arndb.de>
Message-ID: <20131211110243.GM11468@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 11, 2013 at 04:07:27AM +0100, Arnd Bergmann wrote:
> On Tuesday 10 December 2013, Mark Brown wrote:

> > That's not my experience especially once you get into phone type
> > hardware - there's not much complexity difference when gluing things
> > into the system and the fact that it's connected by the board increases
> > the amount of flexibility that has to be coped with.

> Yes, that is probably right. The only argument that one can make about
> the mobile phone case is that these devices are so complex that nobody
> even bothers any more running upstream kernels on them on any CPU
> architecture. If the kernel code is kept out of the mainline tree,
> it doesn't matter to us what they use, and the developers don't gain
> much by following any of the available firmware models either.

It's more of a commercial thing than a complexity thing (complexity adds
a barrier but it's not fundamental) - the designs for phones aren't
meaningfully different to those for tablets, and looking at both things
like the ARM Chromeboos and what the low power Haswell stuff is doing
laptops are looking an awful lot like tablets these days.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131211/92133644/attachment.sig>
