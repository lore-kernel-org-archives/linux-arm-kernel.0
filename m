From: broonie@kernel.org (Mark Brown)
Date: Fri, 14 Aug 2015 17:34:19 +0100
Subject: [PATCH 00/20] Regmap max_raw_io and bmc150 SPI support
In-Reply-To: <20150812104739.GC19600@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <20150812103736.GR10748@sirena.org.uk>
 <20150812104739.GC19600@pengutronix.de>
Message-ID: <20150814163419.GW10748@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 12:47:39PM +0200, Markus Pargmann wrote:

> Ok. I can try to separate them but there are lots of dependencies
> between the patches and most of them touch regmap.c so I thought it may
> be better to put it in one series.

No, just the opposite - it means there's much less structure to the
series as it just becomes a sequence of unrelated changes without
overall aim or common theme.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150814/b7edce91/attachment.sig>
