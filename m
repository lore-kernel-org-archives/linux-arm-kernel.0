From: broonie@kernel.org (Mark Brown)
Date: Mon, 13 Oct 2014 16:49:24 +0200
Subject: [PATCH v2 1/4] regulator: Add ena_gpio_initialized to
 regulator_config
In-Reply-To: <1412776028-15655-2-git-send-email-mpa@pengutronix.de>
References: <1412776028-15655-1-git-send-email-mpa@pengutronix.de>
 <1412776028-15655-2-git-send-email-mpa@pengutronix.de>
Message-ID: <20141013144924.GL27755@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 08, 2014 at 03:47:05PM +0200, Markus Pargmann wrote:
> Most drivers do not set the ena_gpio field of struct regulator_config
> before passing it to the regulator core. This is fine as long as the
> gpio identifier that is passed is a positive integer. But the gpio
> identifier 0 is also valid. So we are not able to decide wether we got a
> real gpio identifier or not based on a 0 in ena_gpio.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141013/1fc644a2/attachment.sig>
