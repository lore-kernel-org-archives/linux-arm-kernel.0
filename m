From: broonie@kernel.org (Mark Brown)
Date: Wed, 26 Feb 2014 08:50:04 +0900
Subject: [PATCH 1/2] regulator: dummy: Should be always-on
In-Reply-To: <1393322627-26543-2-git-send-email-mpa@pengutronix.de>
References: <1393322627-26543-1-git-send-email-mpa@pengutronix.de>
 <1393322627-26543-2-git-send-email-mpa@pengutronix.de>
Message-ID: <20140225235004.GF2927@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 25, 2014 at 11:03:46AM +0100, Markus Pargmann wrote:

> Regulator dummy does not have any enable operations. So it is always_on.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140226/6a740681/attachment.sig>
