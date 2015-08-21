From: broonie@kernel.org (Mark Brown)
Date: Fri, 21 Aug 2015 09:47:09 -0700
Subject: [PATCH v2 1/4] regmap: Introduce max_raw_read/write for
 regmap_bulk_read/write
In-Reply-To: <1440064807-26346-2-git-send-email-mpa@pengutronix.de>
References: <1440064807-26346-1-git-send-email-mpa@pengutronix.de>
 <1440064807-26346-2-git-send-email-mpa@pengutronix.de>
Message-ID: <20150821164709.GF12027@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 20, 2015 at 12:00:04PM +0200, Markus Pargmann wrote:
> There are some buses which have a limit on the maximum number of bytes
> that can be send/received. An example for this is
> I2C_FUNC_SMBUS_I2C_BLOCK which does not support any reads/writes of more
> than 32 bytes. The regmap_bulk operations should still be able to
> utilize the full 32 bytes in this case.

This doesn't seem to apply against current code, can you please check
and resend?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150821/d66efb11/attachment.sig>
