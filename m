From: broonie@kernel.org (Mark Brown)
Date: Tue, 7 Jan 2014 15:38:04 +0000
Subject: [PATCH 05/11] ASoC: ux500_pcm: Stop pretending that we support
 varying address widths
In-Reply-To: <1387468508-12286-6-git-send-email-lee.jones@linaro.org>
References: <1387468508-12286-1-git-send-email-lee.jones@linaro.org>
 <1387468508-12286-6-git-send-email-lee.jones@linaro.org>
Message-ID: <20140107153804.GN31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 19, 2013 at 03:55:02PM +0000, Lee Jones wrote:
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140107/f43b753e/attachment.sig>
