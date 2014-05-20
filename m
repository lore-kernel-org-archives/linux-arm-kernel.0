From: broonie@kernel.org (Mark Brown)
Date: Tue, 20 May 2014 23:05:03 +0100
Subject: [PATCH v4 11/17] ASoC: fsl-ssi: Move fsl_ssi_set_dai_sysclk
 above fsl_ssi_hw_params
In-Reply-To: <1398682498-24357-12-git-send-email-mpa@pengutronix.de>
References: <1398682498-24357-1-git-send-email-mpa@pengutronix.de>
 <1398682498-24357-12-git-send-email-mpa@pengutronix.de>
Message-ID: <20140520220503.GB12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 12:54:52PM +0200, Markus Pargmann wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> fsl_ssi_set_dai_sysclk will be called from fsl_ssi_hw_params in the
> next patch. Move up to avoid forward declaration and to keep the next patch
> more readable. No functional change.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140520/e06b2d86/attachment.sig>
