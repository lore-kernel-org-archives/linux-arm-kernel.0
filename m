From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Wed, 1 Aug 2018 10:00:43 +0200
Subject: [PATCH v8 4/4] mailbox: Add support for i.MX7D messaging unit
In-Reply-To: <AM0PR04MB42113FA3268A1DA75006702B802D0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20180731141146.10788-1-o.rempel@pengutronix.de>
 <20180731141146.10788-5-o.rempel@pengutronix.de>
 <AM0PR04MB42113FA3268A1DA75006702B802D0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <20180801080043.xzoyz4xijjcxlaid@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 01, 2018 at 07:52:43AM +0000, A.s. Dong wrote:
> > -----Original Message-----
> > From: Oleksij Rempel [mailto:o.rempel at pengutronix.de]
> > Sent: Tuesday, July 31, 2018 10:12 PM
> > To: Shawn Guo <shawnguo@kernel.org>; Fabio Estevam
> > <fabio.estevam@nxp.com>; Rob Herring <robh+dt@kernel.org>; Mark
> > Rutland <mark.rutland@arm.com>; A.s. Dong <aisheng.dong@nxp.com>;
> > Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>; Jassi Brar
> > <jassisinghbrar@gmail.com>
> > Cc: Oleksij Rempel <o.rempel@pengutronix.de>; kernel at pengutronix.de;
> > linux-arm-kernel at lists.infradead.org; devicetree at vger.kernel.org; dl-linux-
> > imx <linux-imx@nxp.com>
> > Subject: [PATCH v8 4/4] mailbox: Add support for i.MX7D messaging unit
> > 
> > The Mailbox controller is able to send messages (up to 4 32 bit words)
> > between the endpoints.
> > 
> 
> I'm not sure but is this still valid after change to multi channels mode?
> We actually lost the HW capability to send messages up to 4 words
> in the multi channels mode.
> And such commit message probably will confuse people.
> Worth a improve?
> 
> Otherwise this patch mostly is okay to me except a few bits already
> pointed out by Jassi.

Ok, I schedule this task for Thursday or Friday.

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180801/b9a2ebf3/attachment.sig>
