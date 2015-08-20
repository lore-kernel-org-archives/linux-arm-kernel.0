From: broonie@kernel.org (Mark Brown)
Date: Thu, 20 Aug 2015 11:28:27 -0700
Subject: [PATCH v2 3/5] regmap: Split use_single_rw internally into
 use_single_read/write
In-Reply-To: <1440061956-29064-4-git-send-email-mpa@pengutronix.de>
References: <1440061956-29064-1-git-send-email-mpa@pengutronix.de>
 <1440061956-29064-4-git-send-email-mpa@pengutronix.de>
Message-ID: <20150820182827.GK12027@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 20, 2015 at 11:12:34AM +0200, Markus Pargmann wrote:
> use_single_rw currently reflects the capabilities of the connected
> device. The capabilities of the bus are currently missing for this
> variable.

This is fine but depends on the previous patch.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150820/506dc5fa/attachment.sig>
