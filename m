From: broonie@kernel.org (Mark Brown)
Date: Mon, 3 Jun 2013 16:22:17 +0100
Subject: [PATCH 1/2] spi: atmel: convert to
 dma_request_slave_channel_compat()
In-Reply-To: <1370012520-30539-1-git-send-email-richard.genoud@gmail.com>
References: <1370012520-30539-1-git-send-email-richard.genoud@gmail.com>
Message-ID: <20130603152217.GL31367@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 31, 2013 at 05:01:59PM +0200, Richard Genoud wrote:
> Use generic DMA DT helper.
> Platforms booting with or without DT populated are both supported.
> 
> Based on Ludovic Desroches <ludovic.desroches@atmel.com> patchset
> "ARM: at91: move to generic DMA device tree binding"

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130603/6956c3f8/attachment.sig>
