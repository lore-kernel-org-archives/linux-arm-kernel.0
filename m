From: broonie@kernel.org (Mark Brown)
Date: Thu, 20 Aug 2015 11:20:00 -0700
Subject: [PATCH v2 1/5] regmap: Add missing comments about struct
 regmap_bus
In-Reply-To: <1440061956-29064-2-git-send-email-mpa@pengutronix.de>
References: <1440061956-29064-1-git-send-email-mpa@pengutronix.de>
 <1440061956-29064-2-git-send-email-mpa@pengutronix.de>
Message-ID: <20150820182000.GI12027@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 20, 2015 at 11:12:32AM +0200, Markus Pargmann wrote:

>   * @async_write: Write operation which completes asynchronously, optional and
>   *               must serialise with respect to non-async I/O.
> + * @reg_write: Write operation for a register. Writes value to register.

This seems like documenation for the sake of filling in the blank :(  At
least distinguish it from async_write() please.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150820/dcc2ce53/attachment.sig>
