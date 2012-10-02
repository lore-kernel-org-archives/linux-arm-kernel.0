From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 2 Oct 2012 20:31:50 +0100
Subject: [PATCH] ARM: tegra: remove <mach/dma.h>
In-Reply-To: <1349206245-22560-1-git-send-email-swarren@wwwdotorg.org>
References: <1349206245-22560-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20121002193150.GA4360@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 02, 2012 at 01:30:45PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Remove includes of <mach/dma.h> from sound/soc; nothing from it is used.
> 
> Remove include of <mach/dma.h> from mach-tegra/apbio.c; since the DMA
> transfers made by this file don't need flow-control with any peripheral,
> there's no need to set any slave ID.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
