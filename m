From: broonie@kernel.org (Mark Brown)
Date: Fri, 14 Aug 2015 17:34:51 +0100
Subject: [PATCH 11/20] regmap: _regmap_raw_read: Add handling of busses
 without bus->read()
In-Reply-To: <20150812123412.GG19600@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-12-git-send-email-mpa@pengutronix.de>
 <20150812112707.GY10748@sirena.org.uk>
 <20150812123412.GG19600@pengutronix.de>
Message-ID: <20150814163451.GX10748@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 02:34:12PM +0200, Markus Pargmann wrote:

> Is -EINVAL the right thing to return or would you prefer -ENOTSUPP?

-ENOTSUPP is going to be better.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150814/4556f380/attachment.sig>
