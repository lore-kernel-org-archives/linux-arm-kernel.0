From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Sep 2009 21:20:55 +0100
Subject: LDREX/STREX and pre-emption on SMP hardware
In-Reply-To: <1252938577.16853.122.camel@pc1117.cambridge.arm.com>
References: <1250870319.10642.23.camel@pc1117.cambridge.arm.com>
	<1250890146.29685.18.camel@david-laptop>
	<1251128692.28977.17.camel@pc1117.cambridge.arm.com>
	<1251134043.31975.23.camel@david-laptop>
	<1251135709.28977.40.camel@pc1117.cambridge.arm.com>
	<20090914014353.GA4762@shareable.org>
	<20090914100056.GC16644@n2100.arm.linux.org.uk>
	<1252922773.16853.62.camel@pc1117.cambridge.arm.com>
	<20090914142333.GF21580@n2100.arm.linux.org.uk>
	<1252938577.16853.122.camel@pc1117.cambridge.arm.com>
Message-ID: <20090918202055.GH6601@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 14, 2009 at 03:29:36PM +0100, Catalin Marinas wrote:
> The other case where I replied was discussing the need for CLREX at
> context switch and that's needed to get the correct behaviour (T1 and T2
> are OS threads in this case).

Well, lets get your patch in then.  Please try to get it to me (patch
system / git pull) by tomorrow evening, thanks.
