From: broonie@kernel.org (Mark Brown)
Date: Wed, 19 Sep 2018 10:31:57 -0700
Subject: [PATCH v3] spi: mediatek: Don't modify spi_transfer when transfer.
In-Reply-To: <20180919062928.238917-1-pihsun@chromium.org>
References: <20180918161504.GM2471@sirena.org.uk>
 <20180919062928.238917-1-pihsun@chromium.org>
Message-ID: <20180919173157.GD2471@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 19, 2018 at 02:29:27PM +0800, Peter Shih wrote:
> Mediatek SPI driver modifies some fields (tx_buf, rx_buf, len, tx_dma,
> rx_dma) of the spi_transfer* passed in when doing transfer_one and in
> interrupt handler. This is somewhat unexpected, and there are some

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180919/6c2e6ecc/attachment.sig>
