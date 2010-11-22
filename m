From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 22 Nov 2010 13:49:31 +0000
Subject: [PATCH v2 19/20] ARM: LPAE: define printk format for physical
	addresses and page table entries
In-Reply-To: <20101122134325.GK31227@n2100.arm.linux.org.uk>
References: <1289584840-18097-1-git-send-email-catalin.marinas@arm.com>
	<1289584840-18097-20-git-send-email-catalin.marinas@arm.com>
	<20101122134325.GK31227@n2100.arm.linux.org.uk>
Message-ID: <1290433771.29754.34.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-11-22 at 13:43 +0000, Russell King - ARM Linux wrote:
> On Fri, Nov 12, 2010 at 06:00:39PM +0000, Catalin Marinas wrote:
> > From: Will Deacon <will.deacon@arm.com>
> >
> > Now that the Kernel supports 2 level and 3 level page tables, physical
> > addresses (and also page table entries) may be 32 or 64-bits depending
> > upon the configuration.
> >
> > This patch adds a conversion specifier (PHYS_ADDR_FMT) which represents
> > a u32 or u64 depending on the width of a physical address.
> 
> I hope this patch is gone in v3.

Yes, everything is converted to %08llx now.

Once you complete your clean-up, I'll rebase the LPAE patches on top and
repost a new v4 version.

-- 
Catalin
