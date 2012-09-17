From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 17 Sep 2012 05:47:16 -0400
Subject: [PATCH RESEND 4/5] spi: tegra: remove support of legacy DMA
 driver based access
In-Reply-To: <1347639089-2520-4-git-send-email-swarren@wwwdotorg.org>
References: <1347639089-2520-1-git-send-email-swarren@wwwdotorg.org>
 <1347639089-2520-4-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20120917094715.GA4829@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2012 at 10:11:28AM -0600, Stephen Warren wrote:
> From: Laxman Dewangan <ldewangan@nvidia.com>
> 
> Remove the support code which uses the legacy APB DMA driver
> for accessing the SPI FIFO.
> The driver will use the dmaengine based APB DMA driver for
> accessing reqding/writing to SPI FIFO.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
