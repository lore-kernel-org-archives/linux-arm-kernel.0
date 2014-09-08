From: broonie@kernel.org (Mark Brown)
Date: Mon, 8 Sep 2014 12:16:27 +0100
Subject: [PATCH v2] regmap: Fix debugfs-file 'registers' mode
In-Reply-To: <1410158617-16827-1-git-send-email-mpa@pengutronix.de>
References: <1410158617-16827-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20140908111627.GI4015@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 08, 2014 at 08:43:37AM +0200, Markus Pargmann wrote:
> The macro "REGMAP_ALLOW_WRITE_DEBUGFS" can be used to enable write
> support on the registers file in the debugfs. The mode of the file is
> fixed to 0400 so it is not possible to write the file ever.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140908/5925a2f7/attachment.sig>
