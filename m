From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 22 Aug 2012 16:59:53 +0100
Subject: [PATCH 4/7] regulator: anatop-regulator: convert to use
 imx-syscon to access anatop register
In-Reply-To: <1345619928-15446-5-git-send-email-b29396@freescale.com>
References: <1345619928-15446-1-git-send-email-b29396@freescale.com>
 <1345619928-15446-5-git-send-email-b29396@freescale.com>
Message-ID: <20120822155953.GQ7995@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 22, 2012 at 03:18:45PM +0800, Dong Aisheng wrote:
> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> Using standard imx syscon API to access anatop register.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

With the conversion to regmap it'd also be good to convert the driver to
use the regmap helper functions for enable and voltage operations if
possible.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120822/2b57f4e2/attachment.sig>
