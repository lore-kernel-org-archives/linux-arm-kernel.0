From: tony@atomide.com (Tony Lindgren)
Date: Fri, 12 Nov 2010 09:48:23 -0800
Subject: [PATCH 2/4] omap: dma: Add read-back to DMA interrupt handler
	to avoid spuriousinterrupts
In-Reply-To: <20101112010327.3827.3366.stgit@baageli.muru.com>
References: <20101112010245.3827.75329.stgit@baageli.muru.com>
	<20101112010327.3827.3366.stgit@baageli.muru.com>
Message-ID: <20101112174823.GF9264@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [101111 16:54]:
> From: Mathias Nyman <mathias.nyman@nokia.com>
> 
> Flush the writes to IRQSTATUS_L0 register in the DMA interrupt handler by reading the register
> directly after write. This prevents the spurious DMA interrupts noted when using VDD_OPP 1

Looks like some words in the Subject: got concatenated somewhere,
fixing that.

Tony
