From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Thu, 07 Jul 2011 09:06:54 +0200
Subject: [PATCH] ARM: fix regression in IXP4xx clocksource
In-Reply-To: <20110706211442.GY8286@n2100.arm.linux.org.uk> (Russell King's
	message of "Wed, 6 Jul 2011 22:14:42 +0100")
References: <m3liwb15t2.fsf@intrepid.localdomain>
	<20110706211442.GY8286@n2100.arm.linux.org.uk>
Message-ID: <m3k4buh8mp.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> Did you see Thomas' reply to your last patch?  Would you mind responding
> to that please, before asking Linus to merge this?

I like the BE (or endian-neutral value-preserving) accessor idea.
Nevertheless Linux on IXP4xx doesn't even build at this time and I think
fixing this before 3.0 is well worth it.

I assume changing the common ARM code to use new accessors will happen
post-3.0.

(BTW that was Richard Cochran's patch)
-- 
Krzysztof Halasa
