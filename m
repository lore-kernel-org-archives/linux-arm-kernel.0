From: aisheng.dong@nxp.com (A.s. Dong)
Date: Wed, 1 Aug 2018 07:52:43 +0000
Subject: [PATCH v8 4/4] mailbox: Add support for i.MX7D messaging unit
In-Reply-To: <20180731141146.10788-5-o.rempel@pengutronix.de>
References: <20180731141146.10788-1-o.rempel@pengutronix.de>
 <20180731141146.10788-5-o.rempel@pengutronix.de>
Message-ID: <AM0PR04MB42113FA3268A1DA75006702B802D0@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Oleksij Rempel [mailto:o.rempel at pengutronix.de]
> Sent: Tuesday, July 31, 2018 10:12 PM
> To: Shawn Guo <shawnguo@kernel.org>; Fabio Estevam
> <fabio.estevam@nxp.com>; Rob Herring <robh+dt@kernel.org>; Mark
> Rutland <mark.rutland@arm.com>; A.s. Dong <aisheng.dong@nxp.com>;
> Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>; Jassi Brar
> <jassisinghbrar@gmail.com>
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>; kernel at pengutronix.de;
> linux-arm-kernel at lists.infradead.org; devicetree at vger.kernel.org; dl-linux-
> imx <linux-imx@nxp.com>
> Subject: [PATCH v8 4/4] mailbox: Add support for i.MX7D messaging unit
> 
> The Mailbox controller is able to send messages (up to 4 32 bit words)
> between the endpoints.
> 

I'm not sure but is this still valid after change to multi channels mode?
We actually lost the HW capability to send messages up to 4 words
in the multi channels mode.
And such commit message probably will confuse people.
Worth a improve?

Otherwise this patch mostly is okay to me except a few bits already
pointed out by Jassi.

Regards
Dong Aisheng
