From: gerg@snapgear.com (Greg Ungerer)
Date: Mon, 23 Nov 2009 17:10:30 +1000
Subject: [PATCH 0/10] dma-mapping: cleanup coherent/writealloc
	dma	allocations and ARMv7 memory support
In-Reply-To: <20091121193539.GG13956@n2100.arm.linux.org.uk>
References: <20091120182539.GG16920@n2100.arm.linux.org.uk>
	<20091121193539.GG13956@n2100.arm.linux.org.uk>
Message-ID: <4B0A3566.5060902@snapgear.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Russell,

Russell King - ARM Linux wrote:
> Here's the follow-on patches for cleaning up the DMA support code and
> arranging for coherent DMA allocations to be mapped using the ARMv7
> 'memory' attribute.

I looked at these from a noMMU point of view, and they look good to me.
I you want it, you have an:

Acked-by:  Greg Ungerer <gerg@uclinux.org>

Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg at snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
8 Gardner Close                             FAX:         +61 7 3217 5323
Milton, QLD, 4064, Australia                WEB: http://www.SnapGear.com
