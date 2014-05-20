From: broonie@kernel.org (Mark Brown)
Date: Tue, 20 May 2014 23:02:13 +0100
Subject: [PATCH v4 08/17] ASoC: fsl-ssi: introduce SoC specific data
In-Reply-To: <1398682498-24357-9-git-send-email-mpa@pengutronix.de>
References: <1398682498-24357-1-git-send-email-mpa@pengutronix.de>
 <1398682498-24357-9-git-send-email-mpa@pengutronix.de>
Message-ID: <20140520220213.GZ12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 12:54:49PM +0200, Markus Pargmann wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> Introduce a SoC data struct which contains the differences between
> the different SoCs this driver supports. This makes it easy to support
> more differences without having to introduce a new switch/case each
> time.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---

Applied everything before this patch, thanks.  I've not applied this one
since you didn't sign it off - please make sure when forwarding patches
for other people that you add your signoff at the bottom, this is needed
for legal reasons (see SubmittingPatches).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140520/73570eca/attachment.sig>
