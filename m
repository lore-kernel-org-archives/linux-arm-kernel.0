From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 22 Nov 2010 13:43:25 +0000
Subject: [PATCH v2 19/20] ARM: LPAE: define printk format for physical
	addresses and page table entries
In-Reply-To: <1289584840-18097-20-git-send-email-catalin.marinas@arm.com>
References: <1289584840-18097-1-git-send-email-catalin.marinas@arm.com>
	<1289584840-18097-20-git-send-email-catalin.marinas@arm.com>
Message-ID: <20101122134325.GK31227@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 12, 2010 at 06:00:39PM +0000, Catalin Marinas wrote:
> From: Will Deacon <will.deacon@arm.com>
> 
> Now that the Kernel supports 2 level and 3 level page tables, physical
> addresses (and also page table entries) may be 32 or 64-bits depending
> upon the configuration.
> 
> This patch adds a conversion specifier (PHYS_ADDR_FMT) which represents
> a u32 or u64 depending on the width of a physical address.

I hope this patch is gone in v3.
