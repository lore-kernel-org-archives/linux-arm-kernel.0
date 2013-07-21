From: broonie@kernel.org (Mark Brown)
Date: Mon, 22 Jul 2013 00:57:08 +0100
Subject: [PATCH] ASoC: tegra: correct playback_dma_data setup
In-Reply-To: <1374374049-30732-1-git-send-email-rizhao@nvidia.com>
References: <1374374049-30732-1-git-send-email-rizhao@nvidia.com>
Message-ID: <20130721235708.GF9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 21, 2013 at 10:34:09AM +0800, Richard Zhao wrote:
> The errors were caused by copy/paste mistake in below commit
> since v3.10:
> 3489d50 ASoC: tegra: Use common DAI DMA data struct

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130722/7b2696ea/attachment.sig>
