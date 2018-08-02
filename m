From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Thu, 2 Aug 2018 10:11:36 +0200
Subject: [PATCH v8 5/6] regulator: pfuze100-regulator: provide
 pm_power_off_prepare handler
In-Reply-To: <20180730102452.GH5789@sirena.org.uk>
References: <20180726092220.17250-1-o.rempel@pengutronix.de>
 <20180726092220.17250-6-o.rempel@pengutronix.de>
 <DB6PR04MB32233832762D02F1023861A1892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
 <06313062-70db-9c10-048e-78ca267da959@pengutronix.de>
 <20180730102452.GH5789@sirena.org.uk>
Message-ID: <d76f7acb-b221-8c4f-1dc9-c1244e7b9f49@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 30.07.2018 12:24, Mark Brown wrote:
> On Mon, Jul 30, 2018 at 09:50:55AM +0200, Oleksij Rempel wrote:
>> On 27.07.2018 11:32, Robin Gong wrote:
> 
>>>>  #include <linux/slab.h>
>>>> +#include <linux/kallsyms.h>
> 
>>> Is it necessary?
> 
>> yes, for pm_power_off_prepare
> 
> That's a *weird* header to have to use for that symbol, are you sure
> there isn't something more specific - if there isn't there should be.

Hm... you right. Removed.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180802/ea48d4ed/attachment.sig>
