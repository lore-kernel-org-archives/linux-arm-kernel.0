From: broonie@kernel.org (Mark Brown)
Date: Tue, 7 Oct 2014 12:52:46 +0100
Subject: [PATCH 2/2] regulator: imx-anatop: Fail on invalid voltage
 selector
In-Reply-To: <1412624017-28673-2-git-send-email-mpa@pengutronix.de>
References: <1412624017-28673-1-git-send-email-mpa@pengutronix.de>
 <1412624017-28673-2-git-send-email-mpa@pengutronix.de>
Message-ID: <20141007115246.GV4609@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 06, 2014 at 09:33:37PM +0200, Markus Pargmann wrote:
> A '0' voltage selector is invalid and can't be used with this driver.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141007/1bd32dca/attachment.sig>
