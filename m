From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Nov 2015 19:48:54 +0000
Subject: Cortex-A9 SCU + ARM_ERRATA_764369
In-Reply-To: <5639030E.6070700@free.fr>
References: <5638E61C.30406@free.fr> <20151103172743.GE4049@leverpostej>
 <5639030E.6070700@free.fr>
Message-ID: <20151103194854.GE8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 03, 2015 at 07:55:10PM +0100, Mason wrote:
> Sigh. ARM documentation is such a treasure hunt experience.

It's not that bad, though I do hate the ARM ARM organisation.  I wish
it was split up into a series of stand-alone documents instead of one
huge one - though one huge document does have the advantage of being
trivially searchable.

> Errata Notices are not freely available, thus probably not
> indexed by search engines.
> 
> The other day, I couldn't find what I was looking for in the
> A9MPC TRM, because it was in the A9 TRM. And I suspect the
> architected registers are only documented in the ARM ARM.

Right, so what you do is you download a copy of the PDFs for the Cortex A9
and the ARM ARM, and then either use pdftotext to generate text versions
of them you can grep through, or open each and search through each document
individually.

When you've been working with ARM stuff for a while, you get to know to
start at the ARM ARM, and work upwards to more specific documents - or,
you get to know what kind of information is in which class of document
and then you can go straight to the appropriate doc.

Trust me, the documentation that ARM produces is really nice compared to
the documents that many silicon vendors produce - many of which aren't
worth downloading.  Many barely manage to describe any bit in various
registers adequately, and you're left to experiment by trial and error.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
