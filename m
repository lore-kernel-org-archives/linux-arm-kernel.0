From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Wed, 6 Jun 2012 09:57:54 +0200
Subject: [PATCH] MXS: Add DT binding support into stmp3xxx-rtc
In-Reply-To: <20120606052934.GD2667@S2101-09.ap.freescale.net>
References: <1338084689-12003-1-git-send-email-marex@denx.de>
 <20120606052934.GD2667@S2101-09.ap.freescale.net>
Message-ID: <20431.3458.407509.669784@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Shawn Guo writes:
> On Sun, May 27, 2012 at 04:11:29AM +0200, Marek Vasut wrote:
> > Add simple binding for the stmp3xxx-rtc.
> > 
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Cc: Alessandro Zummo <a.zummo@towertech.it>
> > Cc: devicetree-discuss at lists.ozlabs.org
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > Cc: Rob Herring <rob.herring@calxeda.com>
> > Cc: rtc-linux at googlegroups.com
> > Cc: Shawn Guo <shawn.guo@linaro.org>
> > ---
> >  .../devicetree/bindings/rtc/stmp3xxx-rtc.txt       |   20 ++++++++++++++++++++
> >  arch/arm/boot/dts/imx28.dtsi                       |    1 +
> >  drivers/rtc/rtc-stmp3xxx.c                         |    8 ++++++++
> >  3 files changed, 29 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/rtc/stmp3xxx-rtc.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/rtc/stmp3xxx-rtc.txt b/Documentation/devicetree/bindings/rtc/stmp3xxx-rtc.txt
> > new file mode 100644
> > index 0000000..a49dd52
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/rtc/stmp3xxx-rtc.txt
> > @@ -0,0 +1,20 @@
> > +* STMP3xxx/i.MX28 Time Clock controller
> > +
> > +Required properties:
> > +- compatible: should be one of the following.
> > +    * "fsl,stmp3xxx-rtc"
> > +    * "fsl,imx28-rtc"
> > +- reg: physical base address of the controller and length of memory mapped
> > +  region.
> > +- interrupts: Two interrupt numbers to the cpu should be specified. First
> > +  interrupt number is the rtc rick interupt and second interrupt number
> 
> s/rick/tick?
> 
s/interupt/interrupt/


-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
