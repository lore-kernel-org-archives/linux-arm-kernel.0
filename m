From: aisheng.dong@nxp.com (A.s. Dong)
Date: Wed, 2 May 2018 18:42:50 +0000
Subject: [PATCH 4/6] pinctrl: fsl: add scu based pinctrl support
In-Reply-To: <CACRpkdbiPQ8h_0cD5nkG21wQSq5FrcdNXK1AvE-AP7kWy3yUqw@mail.gmail.com>
References: <1524855713-15527-1-git-send-email-aisheng.dong@nxp.com>
 <1524855713-15527-5-git-send-email-aisheng.dong@nxp.com>
 <CACRpkdY5zSNYvXD3icbO+4R7Mc7TDhHCoUU0gikE6A+=ZFA=Kg@mail.gmail.com>
 <CACRpkdbiPQ8h_0cD5nkG21wQSq5FrcdNXK1AvE-AP7kWy3yUqw@mail.gmail.com>
Message-ID: <AM0PR04MB42114CBFD59FF6AA843DDD7580800@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

> -----Original Message-----
> From: Linus Walleij [mailto:linus.walleij at linaro.org]
> Sent: Wednesday, May 2, 2018 8:29 PM
> To: A.s. Dong <aisheng.dong@nxp.com>
> Cc: open list:GPIO SUBSYSTEM <linux-gpio@vger.kernel.org>; Linux ARM
> <linux-arm-kernel@lists.infradead.org>; Shawn Guo
> <shawnguo@kernel.org>; Stefan Agner <stefan@agner.ch>; Dong Aisheng
> <dongas86@gmail.com>; dl-linux-imx <linux-imx@nxp.com>; Sascha Hauer
> <kernel@pengutronix.de>; Fabio Estevam <fabio.estevam@nxp.com>;
> Fabio Estevam <festevam@gmail.com>
> Subject: Re: [PATCH 4/6] pinctrl: fsl: add scu based pinctrl support
> 
> On Wed, May 2, 2018 at 2:27 PM, Linus Walleij <linus.walleij@linaro.org>
> wrote:
> > On Fri, Apr 27, 2018 at 9:01 PM, Dong Aisheng <aisheng.dong@nxp.com>
> wrote:
> >
> >> Some i.MX SoCs (e.g. MX8QXP and MX8QM) contain a system controller
> >> that is responsible for controlling the pad setting of the IPs that
> >> are present. Communication between the host processor running an OS
> >> and the system controller happens through a SCU protocol.
> >> This patch adds SCU protocol based pinctrl drivers.
> >>
> >> Cc: Linus Walleij <linus.walleij@linaro.org>
> >> Cc: Shawn Guo <shawnguo@kernel.org>
> >> Cc: Fabio Estevam <festevam@gmail.com>
> >> Cc: Stefan Agner <stefan@agner.ch>
> >> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> >> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> >
> > Patch applied.
> 
> Bah on second thought holding this back since I see thyere are some
> discussions about the bindings in the next patch.
> 

Yes :-)

> Anyway, it's nice if the other maintainers would like to get involved.
> 
> Dong: you only need to resend patches 4.5.6 next time.

Got it.

Thanks a lot.

Regards
Dong Aisheng
> 
> Yours,
> Linus Walleij
