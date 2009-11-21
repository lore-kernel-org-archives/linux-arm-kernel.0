From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 21 Nov 2009 19:35:39 +0000
Subject: [PATCH 0/10] dma-mapping: cleanup coherent/writealloc dma
	allocations and ARMv7 memory support
In-Reply-To: <20091120182539.GG16920@n2100.arm.linux.org.uk>
References: <20091120182539.GG16920@n2100.arm.linux.org.uk>
Message-ID: <20091121193539.GG13956@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's the follow-on patches for cleaning up the DMA support code and
arranging for coherent DMA allocations to be mapped using the ARMv7
'memory' attribute.
