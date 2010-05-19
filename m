From: tony@atomide.com (Tony Lindgren)
Date: Tue, 18 May 2010 17:15:33 -0700
Subject: [PATCH 01/13] omap: Fix i2c platform init code for omap4
In-Reply-To: <20100518024243.21705.45209.stgit@baageli.muru.com>
References: <20100518023707.21705.26205.stgit@baageli.muru.com>
	<20100518024243.21705.45209.stgit@baageli.muru.com>
Message-ID: <20100519001533.GY5818@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [100517 19:37]:
> Add separate omap_i2c_add_bus functions for mach-omap1
> and mach-omap2. Make the mach-omap2 init set the interrupt
> dynamically to support.
> 
> This is needed to add support for omap4 in a way that
> works with multi-omap builds. This will eventually get
> fixed with the omap hwmods.

Looks like these first two patches cause a self-created merge
conflict with Ben's i2c branch. Reposting the first two patches
rebased on what's in for-next.

Regards,

Tony
-------------- next part --------------
A non-text attachment was scrubbed...
Name: omap-i2c-multiboot.patch
Type: text/x-diff
Size: 2971 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100518/1de7ff10/attachment-0001.bin>
