From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 12 Nov 2014 15:06:06 +0530
Subject: [PATCH RESEND v2 0/2] ARM: sun8i: Add DMA controller support
In-Reply-To: <1415333747-24075-1-git-send-email-wens@csie.org>
References: <1415333747-24075-1-git-send-email-wens@csie.org>
Message-ID: <20141112093606.GC24582@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 07, 2014 at 12:15:45PM +0800, Chen-Yu Tsai wrote:
> Hi Vinod,
> 
> This is my sun8i DMA controller series rebased onto slave-dma/next
> (2ffff42 "dmaengine: xdmac: fix print warning on dma_addr_t variable")
> 
> Original cover letter:
> 
> This is v2 of my sun8i DMA controller support series. This series
> adds support for the DMA controller found in the Allwinner A23 SoC.
> It is the same hardware as found in the A31 (sun6i) SoC. In addition
> to reduced physical channels and endpoints, the controller in the A23
> requires an undocumented register to be toggled. That seems to allow
> memory bus access.
> 
> This series is based on my earlier "clk: sun6i: Unify AHB1 clock and
> fix rate calculation" series, which removes the clock muxing calls from
> the sun6i-dma driver. The default PLL6 pre-divider for AHB1 on the A23
> results in an exceedingly high clock rate for AHB1, and the system hangs.
> Also, on the A23, the dma controller happily works even when AHB1 is
> clocked from AXI.

Applied, thanks

-- 
~Vinod
