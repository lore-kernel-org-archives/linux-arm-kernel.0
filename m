From: broonie@kernel.org (Mark Brown)
Date: Sat, 16 Nov 2013 10:14:22 +0000
Subject: [PATCH 23/31] spi: tegra: convert to standard DMA DT bindings
In-Reply-To: <1384548866-13141-24-git-send-email-swarren@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-24-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20131116101422.GK15393@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 15, 2013 at 01:54:18PM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> By using dma_request_slave_channel_or_err(), the DMA slave ID can be

Acked-by: Mark Brown <broonie@linaro.org>

Is this function introduced earlier in the series?  One of the things
I'm looking at is trying to factor out some DMA code in the SPI
framework so perhaps using this straight off would be good.  But perhaps
the channel request stuff will all be in the drivers and it'll just pass
a handle to the framework code so there'll be no issue.

Acked-by: Mark Brown <broonie@linaro.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131116/b159256d/attachment.sig>
