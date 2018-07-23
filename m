From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Mon, 23 Jul 2018 21:03:21 +0530
Subject: [PATCH v6 0/5] add mailbox support for i.MX7D
In-Reply-To: <AM0PR04MB4211B82FD69B41B27465F5E580570@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20180722063923.30222-1-o.rempel@pengutronix.de>
 <AM0PR04MB4211B82FD69B41B27465F5E580570@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <CABb+yY1r=Sg64t3j45XXSJu-_HYx2Uya0WLDHP82stiQ4vnM5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 22, 2018 at 4:14 PM, A.s. Dong <aisheng.dong@nxp.com> wrote:
> Hi Oleksij,
>
> Thanks for the work.
>
> Hi Jassi,
> Do you think if we can have your tag and let those patches go through
> Shawn's tree as the later QXP support patches depends on them?
>
Hmm...  I don't find the 5 patches in my mailbox. Are you sure I was CC'ed?

 Dong Aisheng (2):
   dt-bindings: mailbox: allow mbox-cells to be equal to 0
   dt-bindings: arm: fsl: add mu binding doc

 Oleksij Rempel (3):
   dt-bindings: mailbox: imx-mu: add generic MU channel support
   ARM: dts: imx7s: add i.MX7 messaging unit support
   mailbox: Add support for i.MX7D messaging unit
