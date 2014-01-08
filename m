From: broonie@kernel.org (Mark Brown)
Date: Wed, 8 Jan 2014 17:18:54 +0000
Subject: [PATCH v4 2/9] ASoC: fsl-ssi: Move sysfs stats to debugfs
In-Reply-To: <1387545096-2334-3-git-send-email-mpa@pengutronix.de>
References: <1387545096-2334-1-git-send-email-mpa@pengutronix.de>
 <1387545096-2334-3-git-send-email-mpa@pengutronix.de>
Message-ID: <20140108171854.GN31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 20, 2013 at 02:11:29PM +0100, Markus Pargmann wrote:
> Interrupt statistics of fsl_ssi are mainly for debugging purpose. Most
> of those interrupts show error states, e.g. under/overflow.
> The stats should be exposed via debugfs instead of sysfs.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140108/c2830b7b/attachment-0001.sig>
