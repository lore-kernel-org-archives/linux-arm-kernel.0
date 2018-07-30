From: broonie@kernel.org (Mark Brown)
Date: Mon, 30 Jul 2018 11:24:52 +0100
Subject: [PATCH v8 5/6] regulator: pfuze100-regulator: provide
 pm_power_off_prepare handler
In-Reply-To: <06313062-70db-9c10-048e-78ca267da959@pengutronix.de>
References: <20180726092220.17250-1-o.rempel@pengutronix.de>
 <20180726092220.17250-6-o.rempel@pengutronix.de>
 <DB6PR04MB32233832762D02F1023861A1892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
 <06313062-70db-9c10-048e-78ca267da959@pengutronix.de>
Message-ID: <20180730102452.GH5789@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2018 at 09:50:55AM +0200, Oleksij Rempel wrote:
> On 27.07.2018 11:32, Robin Gong wrote:

> >>  #include <linux/slab.h>
> >> +#include <linux/kallsyms.h>

> > Is it necessary?

> yes, for pm_power_off_prepare

That's a *weird* header to have to use for that symbol, are you sure
there isn't something more specific - if there isn't there should be.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180730/82a8afad/attachment.sig>
