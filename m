From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 17 Sep 2012 05:47:37 -0400
Subject: [PATCH RESEND 5/5] ASoC: tegra: remove support of legacy DMA
 driver based access
In-Reply-To: <1347639089-2520-5-git-send-email-swarren@wwwdotorg.org>
References: <1347639089-2520-1-git-send-email-swarren@wwwdotorg.org>
 <1347639089-2520-5-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20120917094736.GB4829@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2012 at 10:11:29AM -0600, Stephen Warren wrote:
> From: Laxman Dewangan <ldewangan@nvidia.com>
> 
> Remove the support code which uses the legacy APB DMA driver
> for accessing the I2S FIFO.
> The driver will use the dmaengine based APB DMA driver for
> accessing reqding/writing to I2S FIFO.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
