From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Sun, 8 Aug 2010 17:14:24 +0530
Subject: [PATCH 1/3] ARM: mmu: Setup MT_MEMORY and MT_MEMORY_NONACHED	L1
	entries
In-Reply-To: <20100808113550.GB23623@n2100.arm.linux.org.uk>
References: <1281262672-27626-1-git-send-email-santosh.shilimkar@ti.com>
	<20100808113550.GB23623@n2100.arm.linux.org.uk>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C64A2362@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Sunday, August 08, 2010 5:06 PM
> To: Shilimkar, Santosh
> Cc: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 1/3] ARM: mmu: Setup MT_MEMORY and MT_MEMORY_NONACHED
> L1 entries
> 
> On Sun, Aug 08, 2010 at 03:47:52PM +0530, Santosh Shilimkar wrote:
> > This patch populates the L1 entries for MT_MEMORY and MT_MEMORY_NONACHED
> 
> Spelling.
> 
> > types so that at boot-up, we can map memories outside system memory
> > at page level granularity
> 
> If you're only using MT_MEMORY_NONCACHED (it seems so from patch 4),
> please only modify that entry.

Patch 2 uses "MT_MEMORY_NONCACHED" for OMAP3 and MT_MEMORY for
rest of the OMAPs. So we need both.

Regards,
Santosh
