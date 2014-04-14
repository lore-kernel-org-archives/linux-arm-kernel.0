From: broonie@kernel.org (Mark Brown)
Date: Mon, 14 Apr 2014 21:02:08 +0100
Subject: [PATCH 1/5] spi: sirf: correct TXFIFO empty interrupt status bit
In-Reply-To: <1397457001-5266-2-git-send-email-21cnbao@gmail.com>
References: <1397457001-5266-1-git-send-email-21cnbao@gmail.com>
 <1397457001-5266-2-git-send-email-21cnbao@gmail.com>
Message-ID: <20140414200208.GT25182@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 14, 2014 at 02:29:57PM +0800, Barry Song wrote:
> From: Qipan Li <Qipan.Li@csr.com>
> 
> the old code uses wrong marco - SIRFSOC_SPI_FIFO_FULL is not for
> FIFO interrupt status, it is for FIFO status. here in the ISR,
> SIRFSOC_SPI_TXFIFO_EMPTY is the right bit for SPI TXFIFO interrupt
> status.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140414/b3b4ad33/attachment.sig>
