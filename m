From: broonie@kernel.org (Mark Brown)
Date: Wed, 8 Jan 2014 17:18:21 +0000
Subject: [PATCH v4 3/9] ASoC: fsl-ssi: Add imx51-ssi and of_device_id
 matching
In-Reply-To: <1387545096-2334-4-git-send-email-mpa@pengutronix.de>
References: <1387545096-2334-1-git-send-email-mpa@pengutronix.de>
 <1387545096-2334-4-git-send-email-mpa@pengutronix.de>
Message-ID: <20140108171821.GL31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 20, 2013 at 02:11:30PM +0100, Markus Pargmann wrote:

> This patch introduces distinct imx51-ssi as compatible and adds
> of_device_id matching in the probe function.

This is missing an update to the binding documentation adding the new
compatible types.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140108/5b2b25e5/attachment.sig>
