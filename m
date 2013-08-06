From: broonie@kernel.org (Mark Brown)
Date: Tue, 6 Aug 2013 11:20:44 +0100
Subject: [PATCH] spi: sirf: use DMA if both buffer address and length are
 aligned
In-Reply-To: <1375770081-12873-1-git-send-email-Baohua.Song@csr.com>
References: <1375770081-12873-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <20130806102044.GA13956@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 06, 2013 at 02:21:21PM +0800, Barry Song wrote:
> this patch enables DMA support for SiRFSoC SPI driver, if both
> buffers and length are aligned with DMA controller's hardware
> limitation, use generic SiRF generic dmaengine driver.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130806/c3f3e550/attachment.sig>
