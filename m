From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Mon, 30 Jul 2018 18:34:56 +0530
Subject: [PATCH v7 3/6] dt-bindings: mailbox: imx-mu: add generic MU
 channel support
In-Reply-To: <bf7aca98-7ec8-bcf3-b1a8-d86a7cf28d31@pengutronix.de>
References: <20180726065331.6186-1-o.rempel@pengutronix.de>
 <20180726065331.6186-4-o.rempel@pengutronix.de>
 <CABb+yY0kVFvQRBrU4j9t=_JcSUkcXMMSK5u=XSufM6XcmKiv-g@mail.gmail.com>
 <AM0PR04MB42116C756EC78AD12EB254D6802B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <CABb+yY0yn9os6nqH8eUfAr3Q3ev4=TfpTp=5ZDBR7FN67eb-wg@mail.gmail.com>
 <VI1PR04MB4222672B8F7B6AF2B11A4442802A0@VI1PR04MB4222.eurprd04.prod.outlook.com>
 <CABb+yY1EkHk85H72xYoYA3JbQL03+-o3UcRVdA_Zub-Q+D=OHw@mail.gmail.com>
 <VI1PR04MB422216469EE5F3ED8E53A4F1802A0@VI1PR04MB4222.eurprd04.prod.outlook.com>
 <CABb+yY0SfdFr8TMOMosTVb5+LFWqB8nQkKj3ze8usi-s7Cko4g@mail.gmail.com>
 <VI1PR04MB4222B4877B341C0FA07A6A8D802A0@VI1PR04MB4222.eurprd04.prod.outlook.com>
 <CABb+yY1MSSQKZ6BOQXC-x=qy4VZ5HqDBjmh_BJTXSkAm3+P8mA@mail.gmail.com>
 <bf7aca98-7ec8-bcf3-b1a8-d86a7cf28d31@pengutronix.de>
Message-ID: <CABb+yY3PLcjduxm7uJ9xZpPP2zkcQ5Qngs4PjnhGAXp43QVzFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2018 at 1:05 PM, Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> Hi Aishen, Jassie,
>
> i'm lost in this discussion. Please, as soon as I need to add some
> changes to my patches, notify me. Preferably on top for email.
>
I am ok with however you choose to implement, 8 unidirectional or 4
bidirectional channels or whatever.

We just can't have protocol specific s/w modes in the controller drivers.

The best solution is to fix the SCU firmware. If that is _really_
impossible, I provided a solution (3 cells work around). If you have a
better idea please feel free to propose and implement that.

It will also help if you could share the user code of "scu-mode". If
there is no such code (and we know the driver doesn't respect the
"scu-mode" property) why do we even have that binding? Maybe drop it.

thnx.
