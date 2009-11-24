From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 Nov 2009 16:56:22 +0000
Subject: [RFC 10/11] ARM: arrange for flush_cache_range() toalwaysflush
	the I-cache
In-Reply-To: <1259081574.16239.34.camel@pc1117.cambridge.arm.com>
References: <20091123202856.GG18142@n2100.arm.linux.org.uk>
	<1259067956.13956.17.camel@pc1117.cambridge.arm.com>
	<20091124144623.GA14462@n2100.arm.linux.org.uk>
	<1259081574.16239.34.camel@pc1117.cambridge.arm.com>
Message-ID: <20091124165622.GB17481@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 24, 2009 at 04:52:54PM +0000, Catalin Marinas wrote:
> OK, no problem. I thought you have a bigger pile of patches and just
> squeeze this change somewhere. I'll post a new patch.

I do - my plan all along was to add your patch on top of my 'cup' branch
(which is intended to contain all the copy_user_page fixes) and then merge
that into the appropriate place in the 'cache' series of branches.
