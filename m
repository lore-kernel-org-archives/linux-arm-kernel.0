From: anson.huang@nxp.com (Anson Huang)
Date: Tue, 9 Jan 2018 09:36:00 +0000
Subject: [PATCH V2 2/2] ARM: dts: imx7s: add snvs rtc clock
In-Reply-To: <CAOMZO5DKsgydHaoKrrRngMck_9aQqFja9SParvDiD6V79ryuHg@mail.gmail.com>
References: <1515466276-5541-1-git-send-email-Anson.Huang@nxp.com>
 <1515466276-5541-2-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5DKsgydHaoKrrRngMck_9aQqFja9SParvDiD6V79ryuHg@mail.gmail.com>
Message-ID: <AM3PR04MB1315C4E150966727F46A4029F5100@AM3PR04MB1315.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Best Regards!
Anson Huang


> -----Original Message-----
> From: Fabio Estevam [mailto:festevam at gmail.com]
> Sent: 2018-01-09 5:27 PM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: Horia Geant? <horia.geanta@nxp.com>; Aymen Sghaier
> <aymen.sghaier@nxp.com>; Herbert Xu <herbert@gondor.apana.org.au>;
> David S. Miller <davem@davemloft.net>; Rob Herring <robh+dt@kernel.org>;
> Mark Rutland <mark.rutland@arm.com>; Shawn Guo <shawnguo@kernel.org>;
> Sascha Hauer <kernel@pengutronix.de>; Fabio Estevam
> <fabio.estevam@nxp.com>; Russell King - ARM Linux <linux@armlinux.org.uk>;
> Michael Turquette <mturquette@baylibre.com>; Stephen Boyd
> <sboyd@codeaurora.org>; Adriana Reus <adriana.reus@nxp.com>; Stefan
> Agner <stefan@agner.ch>; Dong Aisheng <dongas86@gmail.com>; open
> list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
> <devicetree@vger.kernel.org>; linux-clk at vger.kernel.org; linux-
> crypto at vger.kernel.org; moderated list:ARM/FREESCALE IMX / MXC ARM
> ARCHITECTURE <linux-arm-kernel@lists.infradead.org>; linux-kernel <linux-
> kernel at vger.kernel.org>
> Subject: Re: [PATCH V2 2/2] ARM: dts: imx7s: add snvs rtc clock
> 
> Hi Anson,
> 
> On Tue, Jan 9, 2018 at 12:51 AM, Anson Huang <Anson.Huang@nxp.com>
> wrote:
> 
> > +   - clocks
> > +      Usage: required if SNVS LP RTC requires explicit enablement of clocks
> > +      Value type: <prop_encoded-array>
> > +      Definition:  A list of phandle and clock specifier pairs describing
> > +          the clocks required for enabling and disabling SNVS LP RTC.
> 
> 
> It is a single clock that is used here, so it would be better to describe the text as:
> 
>       Definition:  A clock specifier describing the clock required for enabling and
> disabling SNVS LP RTC
> 
> > +   - clock-names
> > +      Usage: required if SNVS LP RTC requires explicit enablement of clocks
> > +      Value type: <string>
> > +      Definition: A list of clock name strings in the same order as the
> > +          clocks property.
> 
> and here you must describe that the name should be "snvs-rtc":
> 
>       Definition: Clock name string should be "snvs-rtc".


Agree, thanks. Will resend the patch.

Anson.
