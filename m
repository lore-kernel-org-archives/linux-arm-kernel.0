From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 13 Aug 2011 15:33:58 +0100
Subject: [PATCH v7 02/16] ARM: LPAE: Cast the dma_addr_t argument to
	unsigned long in dma_to_virt
In-Reply-To: <1312988619-16804-3-git-send-email-catalin.marinas@arm.com>
References: <1312988619-16804-1-git-send-email-catalin.marinas@arm.com>
	<1312988619-16804-3-git-send-email-catalin.marinas@arm.com>
Message-ID: <20110813143358.GO4775@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2011 at 04:03:25PM +0100, Catalin Marinas wrote:
> This is to avoid a compiler warning when invoking the __bus_to_virt()
> macro. The dma_to_virt() function gets addresses within the 32-bit
> range.

Ok.
