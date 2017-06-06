From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 6 Jun 2017 16:32:12 +0100
Subject: [PATCH 00/10] irqchip: sunxi-nmi: Cleanups and fix A31 R_INTC
 register offset
In-Reply-To: <20170606055932.22548-1-wens@csie.org>
References: <20170606055932.22548-1-wens@csie.org>
Message-ID: <5b984efe-100c-67f9-4ff4-e03ab5366182@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/17 06:59, Chen-Yu Tsai wrote:
> Hi everyone,
> 
> This is an alternative to Icenowy's recent A64 R_INTC patches.
> 
> This is a two part series. The first four patches clean up the existing
> sunxi-nmi driver. Patches five and six add a new "sun6i-a31-r-intc"
> compatible, which mainly adjusts or removes the awkward register region
> offset the old "sun6i-a31-sc-nmi" compatible needed. The remaining
> patches fix or add device nodes for SoC's having this hardware.
> 
> Using "sun6i-a31-r-intc" introduced in this series, instead of Icenowy's
> "sun50i-a64-r-intc" is preferred. This follows our policy of naming
> hardware blocks and compatibles after their first occurrence.
> 
> The first six patches should go through the irqchip tree, while we
> (sunxi) can take the device tree changes after the driver has been
> merged, to avoid breaking linux-next as a whole.

So should I drop the original two patches and take those six instead?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
