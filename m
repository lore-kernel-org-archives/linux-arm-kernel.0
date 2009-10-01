From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 1 Oct 2009 16:04:24 +0100
Subject: [PATCH] arm: fix valid_phys_addr_range() range check
In-Reply-To: <200909240624.n8O6O4MO002196@localhost.localdomain>
References: <200909240624.n8O6O4MO002196@localhost.localdomain>
Message-ID: <20091001150424.GB28044@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 24, 2009 at 04:24:04PM +1000, Greg Ungerer wrote:
> arm: fix valid_phys_addr_range() range check
> 
> Commit 1522ac3ec95ff0230e7aa516f86b674fdf72866c
> ("Fix virtual to physical translation macro corner cases")
> breaks the end of memory check in valid_phys_addr_range().
> The modified expression results in the apparent /dev/mem size
> being 2 bytes smaller than what it actually is.
> 
> This patch reworks the expression to correctly check the address,
> while maintaining use of a valid address to __pa().

Looks good, can you please send it to the patch system?
