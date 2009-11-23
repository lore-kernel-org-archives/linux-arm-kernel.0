From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 23 Nov 2009 12:05:23 +0000
Subject: [PATCH 2/7] ARM: dma-mapping: simplify page_to_dma()
	and__pfn_to_bus()
In-Reply-To: <E1NBYE2-0005kv-7H@rmk-PC.arm.linux.org.uk>
References: <E1NBYE2-0005kv-7H@rmk-PC.arm.linux.org.uk>
Message-ID: <1258977924.8088.15.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2009-11-20 at 18:02 +0000, Russell King - ARM Linux wrote:
> The non-highmem() and the __pfn_to_bus() based page_to_dma() both
> compile to the same code, so its pointless having these two different
> approaches.  Use the __pfn_to_bus() based version.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

-- 
Catalin
