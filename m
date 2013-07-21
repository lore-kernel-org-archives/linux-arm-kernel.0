From: swarren@wwwdotorg.org (Stephen Warren)
Date: Sat, 20 Jul 2013 21:55:26 -0600
Subject: [PATCH] ASoC: tegra: correct playback_dma_data setup
In-Reply-To: <1374374049-30732-1-git-send-email-rizhao@nvidia.com>
References: <1374374049-30732-1-git-send-email-rizhao@nvidia.com>
Message-ID: <51EB5BAE.2070306@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/20/2013 08:34 PM, Richard Zhao wrote:
> The errors were caused by copy/paste mistake in below commit
> since v3.10:
> 3489d50 ASoC: tegra: Use common DAI DMA data struct
> 
> It also corrects slave_id initialization in tegra20_ac97 driver.

Acked-by: Stephen Warren <swarren@nvidia.com>

Hmm, that's what I get for only testing I2S and not SPDIF or AC'97 (not
that I can test the latter).
