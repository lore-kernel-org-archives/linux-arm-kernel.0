From: aisheng.dong@nxp.com (A.s. Dong)
Date: Thu, 12 Jul 2018 04:06:49 +0000
Subject: [PATCH V4 3/5] mailbox: imx: add imx mu support
In-Reply-To: <CABb+yY0XQwXjVUMiXcqFVVCTR2jRWA343d220LqBYmTp+s6J1Q@mail.gmail.com>
References: <1531061817-1980-1-git-send-email-aisheng.dong@nxp.com>
 <1531061817-1980-4-git-send-email-aisheng.dong@nxp.com>
 <20180710141940.oed3kwhbplnykl36@pengutronix.de>
 <AM0PR04MB42113391A6EA741E2767C74B805A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20180711075456.npwfpm6mtpkx7k76@pengutronix.de>
 <AM0PR04MB42119DAE987CDF871CA8CFC6805A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <CABb+yY1kH8mr3=nazsLXrLaNWT0x6j9MizVaE+bZaHmrsKn-Wg@mail.gmail.com>
 <AM0PR04MB4211AD523CFB8DA99AB05EFC805A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <CABb+yY0SqUFfS0ts9QHnKbqH0YW5-dLw7PxcjVa3eK_c3zrNpA@mail.gmail.com>
 <AM0PR04MB4211F30775A0C806F44626C8805A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <CABb+yY0XQwXjVUMiXcqFVVCTR2jRWA343d220LqBYmTp+s6J1Q@mail.gmail.com>
Message-ID: <AM0PR04MB42112EEF9BC36AD54C1B90CC80590@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jassi,

> -----Original Message-----
> From: Jassi Brar [mailto:jassisinghbrar at gmail.com]
> Sent: Thursday, July 12, 2018 1:01 AM
> To: A.s. Dong <aisheng.dong@nxp.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>; linux-arm-
> kernel at lists.infradead.org; dongas86 at gmail.com; linux-
> kernel at vger.kernel.org; Oleksij Rempel <o.rempel@pengutronix.de>; dl-
> linux-imx <linux-imx@nxp.com>; kernel at pengutronix.de; Fabio Estevam
> <fabio.estevam@nxp.com>; shawnguo at kernel.org
> Subject: Re: [PATCH V4 3/5] mailbox: imx: add imx mu support

....

> >
> > bcm seems is using peek to receive data, not only checking the data
> > availability, right?
> > drivers/mailbox/bcm-flexrm-mailbox.c
> >
> As I said, if fetching data from remote don't need to sleep, you can call
> mbox_chan_received_data() from peek(). Otherwise not.

Got it. So it seems work for i.MX.
Thanks.

Regards
Dong Aisheng
