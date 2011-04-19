From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 19 Apr 2011 17:18:46 +0100
Subject: [RFC PATCH v2] Consolidate SRAM support
In-Reply-To: <20110419160135.GA4204@game.jcrosoft.org>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk>
	<20110418085259.GA26044@n2100.arm.linux.org.uk>
	<20110419160135.GA4204@game.jcrosoft.org>
Message-ID: <20110419161846.GB24972@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2011 at 06:01:35PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> Hi,
> 
> 	I do post a patch to add the support to specify a virt and phys
> 	address to the generic allocator so the pv-pool.c is not needed
> 	we can just use the generic fucntion

You've talked about this before in the thread, but the patch never appeared.
