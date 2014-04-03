From: broonie@kernel.org (Mark Brown)
Date: Thu, 3 Apr 2014 23:14:06 +0100
Subject: [PATCH v2 00/16] ASoC: fsl-ssi: Driver cleanup
In-Reply-To: <1394887464-969-1-git-send-email-mpa@pengutronix.de>
References: <1394887464-969-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20140403221406.GI14763@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 15, 2014 at 01:44:08PM +0100, Markus Pargmann wrote:
> Hi,
> 
> This new version of the cleanup is mainly a reordering of the patches. It moves
> the regmap patch to the end of the series so none of the other patches depend
> on it. This also fixes a bug I introduced in "Remove fsl_ssi_setup" which also
> removed the switching between network and normal mode depending on the number
> of channels. I reversed this code removal. Another new patch was added "Fix
> i2s_mode variable setup" which fixes the i2s_mode assignment in set_dai_fmt().

It's been nearly three weeks with no response to this except for the
last patch - I've got ahead and applied since it all looks sane (modulo
the bugfix question), we can see if problems occur in -next after the
merge window.  Thanks!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140403/94c9c1e5/attachment.sig>
