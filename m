From: broonie@kernel.org (Mark Brown)
Date: Mon, 2 Dec 2013 19:09:13 +0000
Subject: [PATCH 1/3] ASoC: ux500_pcm: Stop pretending that we support
 varying address widths
In-Reply-To: <1386007222-10081-1-git-send-email-lee.jones@linaro.org>
References: <1386007222-10081-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20131202190913.GQ27568@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 02, 2013 at 06:00:20PM +0000, Lee Jones wrote:
> The Slave Config's addr_width attribute is populated by data_width of
> dma_cfg, which in turn is derived from dma_params' data_size attribute
> and that comes from the slot_width which is always 16 bits (2 Bytes).
> We're cutting out the middle man here and just setting the DMA Slave
> Config directly.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131202/c6d196b8/attachment-0001.sig>
