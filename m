From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 17 May 2010 11:42:16 +0100
Subject: [PATCH] Optionally allow ARMv6 to use 'normal, bufferable'
	memoryfor DMA
In-Reply-To: <20100515095845.GA17080@n2100.arm.linux.org.uk>
References: <20100515095845.GA17080@n2100.arm.linux.org.uk>
Message-ID: <1274092936.6053.31.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Sat, 2010-05-15 at 10:58 +0100, Russell King - ARM Linux wrote:
> Provide a configuration option to allow the ARMv6 to use normal
> bufferable memory for coherent DMA.  This option is forced to 'y'
> for ARMv7, and offered as a configuration option on ARMv6.
> 
> Enabling this option requires drivers to have the necessary barriers
> to ensure that data in DMA coherent memory is visible prior to the
> DMA operation commencing.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

I'm fined with this patch. So it will default to 'y' even on ARMv6 UP
cores (which I don't mind).

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

-- 
Catalin
