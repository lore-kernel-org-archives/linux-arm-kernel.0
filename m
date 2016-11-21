From: broonie@kernel.org (Mark Brown)
Date: Mon, 21 Nov 2016 19:18:47 +0000
Subject: [PATCH v2 1/4] spi: spi-fsl-dspi: Fix SPI transfer issue when
 using multiple SPI_IOC_MESSAGE
In-Reply-To: <bbdbc8df434dd2af74eb351b799a2812a1c1967e.1479706671.git.maitysanchayan@gmail.com>
References: <cover.1479706671.git.maitysanchayan@gmail.com>
 <bbdbc8df434dd2af74eb351b799a2812a1c1967e.1479706671.git.maitysanchayan@gmail.com>
Message-ID: <20161121191847.vg32cwople4qmini@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 21, 2016 at 11:24:01AM +0530, Sanchayan Maity wrote:
> Current DMA implementation had a bug where the DMA transfer would
> exit the loop in dspi_transfer_one_message after the completion of
> a single transfer. This results in a multi message transfer submitted
> with SPI_IOC_MESSAGE to terminate incorrectly without an error.

Please don't resend already applied patches.  If there are any changes
needed please send incremental changes on top of what's already applied.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 455 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161121/59a1e93d/attachment.sig>
