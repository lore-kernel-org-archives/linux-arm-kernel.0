From: broonie@kernel.org (Mark Brown)
Date: Wed, 25 Mar 2015 09:58:15 -0700
Subject: [PATCH resend] ASoC: fsl-ssi: Fix bitclock calculation for
 master mode
In-Reply-To: <1427121972-5059-1-git-send-email-mkl@pengutronix.de>
References: <1427121972-5059-1-git-send-email-mkl@pengutronix.de>
Message-ID: <20150325165814.GJ3572@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 23, 2015 at 03:46:12PM +0100, Marc Kleine-Budde wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> in fsl_ssi_set_bclk we are looking for the best divider by iterating
> over all possible dividers. The divider is in the range 1..256, so

This doesn't apply against current code, please check and resend.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150325/b37dbe63/attachment.sig>
