From: broonie@kernel.org (Mark Brown)
Date: Sat, 16 Nov 2013 10:05:39 +0000
Subject: [PATCH 19/31] ASoC: tegra: convert to standard DMA DT bindings
In-Reply-To: <1384548866-13141-20-git-send-email-swarren@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-20-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20131116100539.GI15393@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 15, 2013 at 01:54:14PM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> By passing no flags when calling snd_dmaengine_pcm_register() from
> tegra_pcm.c, we end up using dma_request_slave_channel() rather than

Acked-by: Mark Brown <broonie@linaro.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131116/4ebac18f/attachment.sig>
