From: broonie@kernel.org (Mark Brown)
Date: Thu, 22 Aug 2013 11:09:34 +0100
Subject: [PATCH v11 5/8] ASoC: fsl-ssi: ac97-slave support
In-Reply-To: <1376924761-4054-6-git-send-email-mpa@pengutronix.de>
References: <1376924761-4054-1-git-send-email-mpa@pengutronix.de>
 <1376924761-4054-6-git-send-email-mpa@pengutronix.de>
Message-ID: <20130822100934.GV26118@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 19, 2013 at 05:05:58PM +0200, Markus Pargmann wrote:
> This patch adds ac97-slave support.
> 
> For ac97, the registers have to be setup earlier than for other ssi
> modes because there is some communication with the external device
> before streaming. So this patch introduces a fsl_ssi_setup function to
> setup the registers for different ssi operation modes seperately.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130822/0e54354f/attachment.sig>
