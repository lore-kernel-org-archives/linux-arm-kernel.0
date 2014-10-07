From: broonie@kernel.org (Mark Brown)
Date: Tue, 7 Oct 2014 12:51:35 +0100
Subject: [PATCH 1/2] regulator: imx-anatop: Set default voltage selector
 for vddpu
In-Reply-To: <1412624017-28673-1-git-send-email-mpa@pengutronix.de>
References: <1412624017-28673-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20141007115135.GU4609@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 06, 2014 at 09:33:36PM +0200, Markus Pargmann wrote:
> The code reads the default voltage selector from its register. If the
> bootloader disables the regulator, the default voltage selector will be
> 0 which results in faulty behaviour of this regulator driver.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141007/ae7d7892/attachment.sig>
