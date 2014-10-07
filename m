From: broonie@kernel.org (Mark Brown)
Date: Tue, 7 Oct 2014 13:01:06 +0100
Subject: [PATCH 4/5] regulator: Use gpio_is_valid
In-Reply-To: <1412626635-7404-5-git-send-email-mpa@pengutronix.de>
References: <1412626635-7404-1-git-send-email-mpa@pengutronix.de>
 <1412626635-7404-5-git-send-email-mpa@pengutronix.de>
Message-ID: <20141007120106.GY4609@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 06, 2014 at 10:17:14PM +0200, Markus Pargmann wrote:
> Use gpio_is_valid instead of custom check.

Patches per driver please, this isn't just a mechanical transformation.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141007/7c2eb261/attachment-0001.sig>
