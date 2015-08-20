From: broonie@kernel.org (Mark Brown)
Date: Thu, 20 Aug 2015 16:46:29 -0700
Subject: [PATCH v2 0/4] regmap: i2c block support
In-Reply-To: <1440064807-26346-1-git-send-email-mpa@pengutronix.de>
References: <1440064807-26346-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20150820234629.GB12027@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 20, 2015 at 12:00:03PM +0200, Markus Pargmann wrote:
> Hi,
> 
> This series adds support for i2c block read/writes. To support the maximum 32
> byte read/write operations, the regmap core is extended by max_raw_read and
> max_raw_write. bulk operations are splitted depending of the size of
> max_raw_read/write.

This looks basically fine but depends on the previous fixes series
AFAICT.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150820/152cc54d/attachment.sig>
