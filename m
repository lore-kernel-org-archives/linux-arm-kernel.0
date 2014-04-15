From: broonie@kernel.org (Mark Brown)
Date: Tue, 15 Apr 2014 12:40:27 +0100
Subject: [PATCH 1/2] spi: sirf: refactor spi transfer functions
In-Reply-To: <1397546700-21605-1-git-send-email-21cnbao@gmail.com>
References: <1397546700-21605-1-git-send-email-21cnbao@gmail.com>
Message-ID: <20140415114027.GT12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 03:24:59PM +0800, Barry Song wrote:
> From: Qipan Li <Qipan.Li@csr.com>
> 
> split sirfsoc_spi_transfer function into 3 sub-functions:
> spi_sirfsoc_cmd_transfer, spi_sirfsoc_pio_transfer and
> spi_sirfsoc_dma_transfer.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140415/7bd644ac/attachment.sig>
