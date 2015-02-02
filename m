From: broonie@kernel.org (Mark Brown)
Date: Mon, 2 Feb 2015 12:17:43 +0000
Subject: [PATCH v2] spi/xilinx: Fix access invalid memory on xilinx_spi_tx
In-Reply-To: <1422871616-6686-1-git-send-email-ricardo.ribalda@gmail.com>
References: <1422871616-6686-1-git-send-email-ricardo.ribalda@gmail.com>
Message-ID: <20150202121743.GQ21293@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 02, 2015 at 11:06:56AM +0100, Ricardo Ribalda Delgado wrote:
> On 1 and 2 bytes per word, the transfer of the 3 last bytes will access
> memory outside tx_ptr.
> 
> Although this has not trigger any error on real hardware, we should
> better fix this.
> 
> Fixes: 24ba5e593f391507 Remove rx_fn and tx_fn pointer

Applied, thanks.  Fixes: usually has () around the commit title.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150202/f4dcae8d/attachment.sig>
