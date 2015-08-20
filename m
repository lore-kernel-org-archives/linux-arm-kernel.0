From: broonie@kernel.org (Mark Brown)
Date: Thu, 20 Aug 2015 11:32:13 -0700
Subject: [PATCH v2 5/5] regmap: No multi_write support if bus->write does
 not exist
In-Reply-To: <1440061956-29064-6-git-send-email-mpa@pengutronix.de>
References: <1440061956-29064-1-git-send-email-mpa@pengutronix.de>
 <1440061956-29064-6-git-send-email-mpa@pengutronix.de>
Message-ID: <20150820183213.GM12027@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 20, 2015 at 11:12:36AM +0200, Markus Pargmann wrote:
> There is no multi_write support available if we cannot use raw_write.
> This is the case if bus->write is not implemented.
> 
> This patch adds a condition that we need bus and bus->write so that
> can_multi_write is true.

This is fine but doesn't apply (I guess it has a depedency on one of the
earlier patches).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150820/773feef8/attachment.sig>
