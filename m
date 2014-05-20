From: broonie@kernel.org (Mark Brown)
Date: Tue, 20 May 2014 23:04:25 +0100
Subject: [PATCH v4 10/17] ASoC: fsl-ssi: Transmit enable synchronization
In-Reply-To: <1398682498-24357-11-git-send-email-mpa@pengutronix.de>
References: <1398682498-24357-1-git-send-email-mpa@pengutronix.de>
 <1398682498-24357-11-git-send-email-mpa@pengutronix.de>
Message-ID: <20140520220425.GA12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 12:54:51PM +0200, Markus Pargmann wrote:
> When the fsl-ssi unit is used in i2s slave mode, it is possible that the
> SSI unit starts transmitting data on the wrong channel. This happens
> because the SSI does not synchronize with the left-right-clock by
> default.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140520/75160e5e/attachment-0001.sig>
