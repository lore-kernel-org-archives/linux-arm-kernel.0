From: broonie@kernel.org (Mark Brown)
Date: Fri, 28 Aug 2015 18:33:48 +0100
Subject: [PATCH v3 0/4] regmap: i2c block support
In-Reply-To: <1440657872-24554-1-git-send-email-mpa@pengutronix.de>
References: <1440657872-24554-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20150828173348.GS12027@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 27, 2015 at 08:44:28AM +0200, Markus Pargmann wrote:

> Changes in v3:
> - Rebased onto latest version of "regmap: fixes" series

New code not intended as bug fixes needs to apply against the latest
development code, not a fixes branch (and especially not some out of
tree patch series which may have ended up in multiple branches or
something).  git says it doesn't know what you generated this
against...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150828/060ceb9d/attachment.sig>
