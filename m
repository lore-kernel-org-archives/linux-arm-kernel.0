From: ps.report@gmx.net (Peter Seiderer)
Date: Thu, 21 May 2015 08:51:33 +0200
Subject: Aw: Re: [PATCH v1] ARM: dts: nitrogen6x: add CAN support
In-Reply-To: <CAOMZO5Cazk3TGSF1c4pt0WhY2stmJzHWfTyySnf_NyHxaAfgDA@mail.gmail.com>
References: <1432158569-4415-1-git-send-email-ps.report@gmx.net>,
 <CAOMZO5Cazk3TGSF1c4pt0WhY2stmJzHWfTyySnf_NyHxaAfgDA@mail.gmail.com>
Message-ID: <trinity-d429963c-898b-4d71-807a-83565532783d-1432191093655@3capp-gmx-bs69>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Fabio,

> Gesendet: Donnerstag, 21. Mai 2015 um 00:26 Uhr
> Von: "Fabio Estevam" <festevam@gmail.com>
> An: "Peter Seiderer" <ps.report@gmx.net>
> Cc: linux-kernel <linux-kernel@vger.kernel.org>, "Mark Rutland" <mark.rutland@arm.com>, "devicetree at vger.kernel.org" <devicetree@vger.kernel.org>, "Russell King" <linux@arm.linux.org.uk>, "Pawel Moll" <pawel.moll@arm.com>, "Ian Campbell" <ijc+devicetree@hellion.org.uk>, "Rob Herring" <robh+dt@kernel.org>, "Sascha Hauer" <kernel@pengutronix.de>, "Kumar Gala" <galak@codeaurora.org>, "Shawn Guo" <shawn.guo@linaro.org>, "linux-arm-kernel at lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
> Betreff: Re: [PATCH v1] ARM: dts: nitrogen6x: add CAN support
>
> On Wed, May 20, 2015 at 6:49 PM, Peter Seiderer <ps.report@gmx.net> wrote:
> 
> > +               pinctrl_can1_1: can1grp-1 {
> > +                       fsl,pins = <
> > +                               MX6QDL_PAD_KEY_COL2__FLEXCAN1_TX 0x80000000
> > +                               MX6QDL_PAD_KEY_ROW2__FLEXCAN1_RX 0x80000000
> 
> Better not to pass 0x80000000. Use the real PAD settings instead.
> 

Thanks for review, will fix it...

Regards,
Peter
