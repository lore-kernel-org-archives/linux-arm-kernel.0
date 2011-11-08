From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 08 Nov 2011 18:38:12 -0500 (EST)
Subject: [PATCH v8 15/16] ARM: LPAE: add support for ATAG_MEM64
In-Reply-To: <1320682618-1182-16-git-send-email-catalin.marinas@arm.com>
References: <1320682618-1182-1-git-send-email-catalin.marinas@arm.com>
 <1320682618-1182-16-git-send-email-catalin.marinas@arm.com>
Message-ID: <alpine.LFD.2.02.1111081832290.3307@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 7 Nov 2011, Catalin Marinas wrote:

> From: Will Deacon <will.deacon@arm.com>
> 
> LPAE provides support for memory banks with physical addresses of up
> to 40 bits.
> 
> This patch adds a new atag, ATAG_MEM64, so that the Kernel can be
> informed about memory that exists above the 4GB boundary.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

NAK.  Any LPAE capable platform to come is, by definition, a new 
platform.  It therefore should be using DT upfront.


Nicolas
