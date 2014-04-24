From: broonie@kernel.org (Mark Brown)
Date: Thu, 24 Apr 2014 12:44:03 +0100
Subject: [PATCH v3 00/18] ASoC: fsl-ssi: Driver cleanup
In-Reply-To: <1397482548-28463-1-git-send-email-mpa@pengutronix.de>
References: <1397482548-28463-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20140424114403.GN12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 14, 2014 at 03:35:30PM +0200, Markus Pargmann wrote:

> This series is a cleanup of the fsl-ssi driver.

There's been some review comments on this series but only negative ones
and I've not seen any testing reports either.  Are the other patches OK
for people?

> There is no DT binding for regmap yet, as this should be solved in the regmap
> framework first. The current configuration should at least work on the same
> SoCs it was previously used. As soon as we have a common DT binding to set the
> endianess we replace it in this driver.

I'm really not convinced that this is a good idea to be frank - I would
expect devices to still need to be involved to set defaults.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140424/aec79545/attachment.sig>
