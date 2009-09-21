From: jamie@shareable.org (Jamie Lokier)
Date: Mon, 21 Sep 2009 21:32:28 +0100
Subject: What's inside the pxa tree for this merge window
In-Reply-To: <20090921200923.GF30821@n2100.arm.linux.org.uk>
References: <f17812d70909100446h17a1903fy74941945dbfc6943@mail.gmail.com>
	<1253256227.4407.7.camel@pc-matejk>
	<20090918074551.GA26058@n2100.arm.linux.org.uk>
	<Pine.LNX.4.64.0909212111490.17328@axis700.grange>
	<20090921200923.GF30821@n2100.arm.linux.org.uk>
Message-ID: <20090921203228.GC14700@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> Don't blame me for these delays - it's not my choice to impose such
> delays.  I'd really like to fix those broken platforms right now.  I
> just can't do so without causing additional delays for other issues.
> Blame Linus for imposing the "max one pull a week" rule on me.

Fwiw,I'm thinking the clrex-on-exception-return fix, at least, should
go to stable at kernel.org too if it's proving to be reliable, as it
affects userspace correctness on ARMv6+.

-- Jamie
