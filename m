From: broonie@kernel.org (Mark Brown)
Date: Wed, 7 Jun 2017 20:09:01 +0100
Subject: [PATCH linux-next v3 1/4] spi: imx: introduce fifo_size and
 has_dmamode in spi_imx_devtype_data
In-Reply-To: <20170605033809.13726-2-jiada_wang@mentor.com>
References: <20170605033809.13726-1-jiada_wang@mentor.com>
 <20170605033809.13726-2-jiada_wang@mentor.com>
Message-ID: <20170607190901.eo7nmitwj6v3yw5e@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 05, 2017 at 12:38:06PM +0900, Jiada Wang wrote:
> Different ECSPI controller has different fifosize and DMA capability,
> instead of calling functions to identify these information by check
> devtype. add fifo_size and has_dmamode to spi_imx_devtype_data.
> so that these information can be directly accessed.

This doesn't apply against current code, please check and resend
(probably due to Sascha's cleanup series).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170607/239821a7/attachment.sig>
