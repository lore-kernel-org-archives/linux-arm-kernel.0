From: fgenfb@yahoo.com (Harm Hanemaaijer)
Date: Sun, 14 Jul 2013 13:59:57 +0000 (UTC)
Subject: Call for testing/opinions: Optimized memset/memcpy
References: <loom.20130713T172357-560@post.gmane.org>
 <20130713172445.GL32054@1wt.eu> <loom.20130713T232124-511@post.gmane.org>
 <20130714061354.GS32054@1wt.eu> <loom.20130714T124137-382@post.gmane.org>
 <20130714130949.GR24642@n2100.arm.linux.org.uk>
Message-ID: <loom.20130714T154731-132@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux <at> arm.linux.org.uk> writes:

> 
> You're making wrong assumptions about what L1_CACHE_BYTES is.

Thanks for the clarification. I have been focused too much on the concept
of a kernel image customized for a single device.

I can see how having to support multiple platforms with a single kernel
image makes things more difficult, especially when trying to optimize for
something. I will have to think about how to manage this when trying to
optimize memcpy-related functions.
