From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Thu, 1 Aug 2013 07:57:56 +0200
Subject: [PATCH 1/10] ARM: dts: mxs: move 'compatible' property to
 beginning of node and do some whitespace cleanups
In-Reply-To: <51F971B4.1050605@cogentembedded.com>
References: <1375281480-25775-1-git-send-email-LW@KARO-electronics.de>
 <51F971B4.1050605@cogentembedded.com>
Message-ID: <20985.63716.320416.93668@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Sergei Shtylyov writes:
> Hello.
> 
> On 07/31/2013 06:37 PM, Lothar Wa?mann wrote:
> 
> > Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> > ---
> >   arch/arm/boot/dts/imx28.dtsi |    5 ++---
> >   1 files changed, 2 insertions(+), 3 deletions(-)
> 
> > diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> > index 47fc5ef..0360acc 100644
> > --- a/arch/arm/boot/dts/imx28.dtsi
> > +++ b/arch/arm/boot/dts/imx28.dtsi
> > @@ -731,9 +731,9 @@
> >   			};
> >
> >   			dcp at 80028000 {
> > +				compatible = "fsl-dcp";
> 
>     Hm, why not the usual "fsl,dcp", where "fsl" is Freescale's stock ticker?
> 
Don't ask me, but the author of the patch that introduced this
(CC'ed), or the maintainer who accepted this in the first place.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
