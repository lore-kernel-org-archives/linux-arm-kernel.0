From: broonie@kernel.org (Mark Brown)
Date: Sat, 16 Nov 2013 10:04:21 +0000
Subject: [PATCH 18/31] ASoC: tegra: allocate AHUB FIFO during probe() not
 startup()
In-Reply-To: <1384548866-13141-19-git-send-email-swarren@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-19-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20131116100421.GH15393@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 15, 2013 at 01:54:13PM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Teh Tegra30 I2S driver currently allocates DMA FIFOs from the AHUB only
> when an audio stream starts playback. This is theoretically nice for
> resource sharing, but makes no practical difference for any configuration

Acked-by: Mark Brown <broonie@linaro.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131116/84d5f55e/attachment.sig>
