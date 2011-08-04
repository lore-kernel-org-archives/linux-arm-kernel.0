From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Thu, 4 Aug 2011 16:03:14 +0200
Subject: [PATCH 06/12] ARM: IXP23xx: Remove LATCH and CLOCK_TICK_RATE
	dependency
In-Reply-To: <20110804135014.GD1019@plexity.net>
References: <cover.1312455035.git.dsaxena@linaro.org>
	<20110804135014.GD1019@plexity.net>
Message-ID: <20110804140314.GL919@wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 04, 2011 at 06:50:14AM -0700, Deepak Saxena wrote:

> As part of work to remove the global CLOCK_TICK_RATE symbol,
> this patch defines a sub-arch local value for use by the
> ixp23xx code.  Once all LATCH and CLOCK_TICK_RATE references
> are removed, we will remove all the definitions across
> sub-arches.

I posted a patchset back in Oct 2010 that does this:

http://lists.infradead.org/pipermail/linux-arm-kernel/2010-October/029451.html
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-October/029452.html
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-October/029453.html
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-October/029454.html
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-October/029455.html
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-October/029456.html
