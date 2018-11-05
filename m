From: aisheng.dong@nxp.com (A.s. Dong)
Date: Mon, 5 Nov 2018 13:04:02 +0000
Subject: [PATCH V4 05/10] dt-bindings: pinctrl: imx7ulp: back to imx
 legacy binding for consistency
In-Reply-To: <CACRpkdb=1gKHCnd2njRdDbf_dg8H-H3Zmzy8J_H2OoRNa7omnw@mail.gmail.com>
References: <1541149669-10857-1-git-send-email-aisheng.dong@nxp.com>
 <1541149669-10857-6-git-send-email-aisheng.dong@nxp.com>
 <CACRpkdb=1gKHCnd2njRdDbf_dg8H-H3Zmzy8J_H2OoRNa7omnw@mail.gmail.com>
Message-ID: <AM0PR04MB4211131EC2158CF7FC111CA380CA0@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Linus Walleij [mailto:linus.walleij at linaro.org]
> Sent: Friday, November 2, 2018 5:38 PM
[...]
> 
> On Fri, Nov 2, 2018 at 10:13 AM A.s. Dong <aisheng.dong@nxp.com> wrote:
> 
> > We already had an earlier conclusion that all new i.MX Socs will keep
> > using the legacy i.MX Pinctrl bindings instead of generic pin config.
> > However, MX7ULP generic pin config binding support has already been in
> > tree before that time. Per SoC maintainers' suggestions, in order to
> > get a better consistency for all i.MX devices, we'd like to go back to
> > imx legacy binding for MX7ULP as well.
> >
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Stefan Agner <stefan@agner.ch>
> > Cc: Sascha Hauer <kernel@pengutronix.de>
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: linux-gpio at vger.kernel.org
> > Cc: devicetree at vger.kernel.org
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> > ChangeLog:
> >  v3: new patch
> 
> Can I have some ACKs from the other Freescale people on this so I see that
> there is a wide consensus for this?
> 

You can also refer to some comments from here
https://www.spinics.net/lists/arm-kernel/msg683812.html

Sascha & Shawn,
Would you also give a sign-offs?

Regards
Dong Aisheng

> Yours,
> Linus Walleij
