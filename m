From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 22 Dec 2014 11:55:31 +0100 (CET)
Subject: [PATCH] ARM: dts: imx28-evk: remove duplicate property
In-Reply-To: <CAOMZO5Cr2Or5O0c0xjL2Z_Gj6HDGk5vhRckVYw6Q58U+JoZOfQ@mail.gmail.com>
References: <1412715639-9565-1-git-send-email-mhei@heimpold.de>
 <CAOMZO5Cr2Or5O0c0xjL2Z_Gj6HDGk5vhRckVYw6Q58U+JoZOfQ@mail.gmail.com>
Message-ID: <102569001.493493.1419245731445.JavaMail.open-xchange@oxbaltgw00.schlund.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

[Fix Shawn's mail address]

> Fabio Estevam <festevam@gmail.com> hat am 8. Oktober 2014 um 02:18
> geschrieben:
>
>
> On Tue, Oct 7, 2014 at 6:00 PM, Michael Heimpold <mhei@heimpold.de> wrote:
> > Seems to be a left-over from an automatic merge.
> >
> > Signed-off-by: Michael Heimpold <mhei@heimpold.de>
> > Cc: Fabio Estevam <fabio.estevam@freescale.com>
> > ---
> > arch/arm/boot/dts/imx28-evk.dts | 1 -
> > 1 file changed, 1 deletion(-)
> >
> > diff --git a/arch/arm/boot/dts/imx28-evk.dts
> > b/arch/arm/boot/dts/imx28-evk.dts
> > index 09664fc..2944d39 100644
> > --- a/arch/arm/boot/dts/imx28-evk.dts
> > +++ b/arch/arm/boot/dts/imx28-evk.dts
> > @@ -182,7 +182,6 @@
> > };
> >
> > lradc at 80050000 {
> > - fsl,lradc-touchscreen-wires = <4>;
>
> Thanks
>
> Reviewed-by: Fabio Estevam <fabio.estevam@freescale.com>
>

did you get this patch?

Best regards
Stefan Wahren
