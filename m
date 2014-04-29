From: broonie@kernel.org (Mark Brown)
Date: Tue, 29 Apr 2014 09:22:29 -0700
Subject: [PATCH v3 00/18] ASoC: fsl-ssi: Driver cleanup
In-Reply-To: <20140428085453.GC15179@pengutronix.de>
References: <1397482548-28463-1-git-send-email-mpa@pengutronix.de>
 <20140424114403.GN12304@sirena.org.uk>
 <20140428085453.GC15179@pengutronix.de>
Message-ID: <20140429162229.GA16981@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 10:54:53AM +0200, Markus Pargmann wrote:

> What do you think of some framework function like
> of_regmap_parse_endianess()? This would offer a common devicetree
> binding and the driver would still be involved.

Something like that should be fine, Xiubo has been working on it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140429/2c1bf647/attachment.sig>
