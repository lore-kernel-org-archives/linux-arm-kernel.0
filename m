From: broonie@kernel.org (Mark Brown)
Date: Mon, 13 Feb 2017 18:34:30 +0000
Subject: [PATCH] spi/sun6i: Add Master Sample Data Mode for SPI
In-Reply-To: <20170213120553.6479-1-viniciusfre@gmail.com>
References: <20170213120553.6479-1-viniciusfre@gmail.com>
Message-ID: <20170213183430.65vbm3cubid2ljkv@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 13, 2017 at 09:05:53AM -0300, Vinicius Maciel wrote:
> In order to work appropriately, some SPI chips, such as
> max11043, require SPI master samples the data at the
> correct edge.

As I said on another version of this patch this should really be done by
implementing the SPI modes - there isn't one universal configuration for
SPI devices unfortunately.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170213/ce76abd3/attachment.sig>
