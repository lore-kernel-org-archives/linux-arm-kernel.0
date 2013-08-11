From: broonie@kernel.org (Mark Brown)
Date: Sun, 11 Aug 2013 14:07:19 +0100
Subject: [PATCH 1/3] spi: s3c64xx: Zero dma_slave_config struct in
 prepare_dma()
In-Reply-To: <1376181210-14599-1-git-send-email-tomasz.figa@gmail.com>
References: <1376181210-14599-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <20130811130719.GZ6427@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 11, 2013 at 02:33:28AM +0200, Tomasz Figa wrote:
> Not all fields of dma_slave_config struct are being initialized by
> prepare_dma() function, leaving those which are not in undefined state,
> which can confuse DMA drivers using them.

Applied all, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130811/106d0ab1/attachment.sig>
