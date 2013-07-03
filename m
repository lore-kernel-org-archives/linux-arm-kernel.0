From: broonie@kernel.org (Mark Brown)
Date: Wed, 3 Jul 2013 17:07:47 +0100
Subject: [PATCH v9 03/10] ASoC: fsl: Move soc_ac97_ops from imx-ssi to
 fsl_ssi
In-Reply-To: <1371734429-6081-4-git-send-email-mpa@pengutronix.de>
References: <1371734429-6081-1-git-send-email-mpa@pengutronix.de>
 <1371734429-6081-4-git-send-email-mpa@pengutronix.de>
Message-ID: <20130703160747.GR27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 20, 2013 at 03:20:22PM +0200, Markus Pargmann wrote:
> fsl_ssi and imx-ssi can be both enabled at the same time. To be able to
> add AC97 support to fsl_ssi, soc_ac97_ops have to be available to both
> drivers.

This needs to be redone on top of the changes that went into v3.11 to
support multiplatform AC'97 - it won't apply any more.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130703/fb7c3d28/attachment.sig>
