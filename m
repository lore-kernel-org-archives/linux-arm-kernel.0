From: broonie@kernel.org (Mark Brown)
Date: Wed, 2 Dec 2015 19:41:25 +0000
Subject: [PATCH v4 1/5] spi: introduce accelerated read support for spi
 flash devices
In-Reply-To: <1448860515-28336-2-git-send-email-vigneshr@ti.com>
References: <1448860515-28336-1-git-send-email-vigneshr@ti.com>
 <1448860515-28336-2-git-send-email-vigneshr@ti.com>
Message-ID: <20151202194125.GL1929@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 30, 2015 at 10:45:11AM +0530, Vignesh R wrote:
> In addition to providing direct access to SPI bus, some spi controller
> hardwares (like ti-qspi) provide special port (like memory mapped port)
> that are optimized to improve SPI flash read performance.

I'm reasonably OK with this from the SPI side but I'd really like to see
people working on MTD say that this makes sense.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151202/f62b2a94/attachment.sig>
